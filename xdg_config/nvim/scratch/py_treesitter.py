
class MyClass:
    def myfunction(self):
        return 5

    def thing(self, b: int, a: int):
        print("b and a")

        if a < b:
            a = a * 5
            b = 17
            a = int(b / 13)
        else:
            return b

        x = [
                { 'a': a, 'b': b},
                17,
                32,
                """

            multi line string
            """

                ]

        return a

    def otherfunction(self):
        return 10
