from .base import Base

import re

class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'sql'
        self.mark = '[sql]'
        self.rank = 1000
        self.filetypes = ['sql']

        self.description = 'Complete table and column names from an available database'

        self.__column_cache = {}
        self.__table_cache = {}

    # def get_complete_position(self, context):
    #     pos = context['input'].rfind

    def gather_candidates(self, context):
        column_match = re.match(r'.*?(\w+)\.(\w*)\s*$', context['input'])

        if column_match is not None:
            return self._gather_column_candidates(column_match, context)

        # table_match = re.match(r'.*?'
        table_match = None

        if table_match is not None:
            return self._gather_table_candidates(table_match, context)

        return []

    def _gather_table_candidates(self, m, context):
        candidates = [{
            'word': value,
            'kind': 'T',
        } for value in results]

        return candidates

    def _gather_column_candidates(self, m, context):
        table_name = m.group(1)
        column_start = m.group(2)

        if table_name in self.__column_cache and \
                column_start in self.__column_cache[table_name]:
            return self.__column_cache[table_name][column_start]

        sql_query = SqlResult('MS SQL Server', 'square', 'HP_2018Stage1QA_Sql', {
            'TableName': table_name,
            'ColumnStart': column_start,
        })

        results = sql_query.get_result()

        candidates = [{
            'word': value,
            'kind': 'C',
            'menu': '[{0}].[{1}]'.format(table_name, value),
        } for value in results]

        if table_name not in self.__column_cache:
            self.__column_cache[table_name] = {}

        self.__column_cache[table_name][column_start] = candidates

        return candidates


import subprocess


queries = {
    'MS SQL Server': {
        'column': '''
SET NOCOUNT ON

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE
   TABLE_NAME = '$(TableName)'
   AND COLUMN_NAME like '$(ColumnStart)%'
            ''',

        'table': '''
SET NOCOUNT ON

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE
    TABLE_NAME like '$(TableStart)%'
            ''',
    },
}



class SqlResult:
    def __init__(self, sql_type: str, server: str, database: str, variables: dict):
        if sql_type not in queries.keys():
            raise Exception('Not a valid key')

        self.sql_type = sql_type
        self.server = server
        self.database = database
        self.variables = variables

    @property
    def formatted_variables(self):
        return ['{0}={1}'.format(key, value) for key, value in self.variables.items()]

    @property
    def query(self):
        if self.variables.get('TableStart', None) is not None:
            return queries[self.sql_type]['table']

        if self.variables.get('ColumnStart', None) is not None:
            return queries[self.sql_type]['column']

    @property
    def query_string(self):
        return self.query.replace("\n", " ")

    def run(self):
        result = subprocess.run([
            'sqlcmd',
            '-S', self.server,
            '-d', self.database,
            '-W',
            '-h', '-1',
            '-v', *self.formatted_variables,
            '-Q', self.query_string,
        ], shell=True, check=True, timeout=5, stdout=subprocess.PIPE)

        return result

    def get_result(self):
        return self.run().stdout.decode().split()
