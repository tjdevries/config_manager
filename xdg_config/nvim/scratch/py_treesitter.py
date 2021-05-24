
class MyClass:
    def myfunction(self):
        return 5

    def thing(self, b: int, a: int):
        if a < b:
            a = a * 5
            b = 17
            a = int(b / 13)
            return a
        else:
            return b

    def otherfunction(self):
        return 10
