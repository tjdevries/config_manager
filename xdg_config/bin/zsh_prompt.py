
import os
import subprocess

DIR_CACHE = {}


def get_result(command):
    # TODO: Make this use the same subproc

    completed = subprocess.run(command, stdout=subprocess.PIPE)
    result = completed.stdout.decode('utf-8').split('\n')

    return result

class Directory:
    def __init__(self, full_path: str):
        self.full_path = full_path

        self._is_git_dir = None

    @property
    def is_git_directory(self):
        if self._is_git_dir is None:
            if os.path.isdir(self.full_path + '/.git'):
                self._is_git_dir = True
            elif True:
                self._is_git_dir = True
            else:
                self._is_git_dir = False

        return self._is_git_dir
