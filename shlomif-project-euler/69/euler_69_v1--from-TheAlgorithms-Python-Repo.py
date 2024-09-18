"""
Largely based on https://github.com/TheAlgorithms/Python/ . Thanks!
"""


def solution(n: int = 10**6) -> int:
    if n <= 0:
        raise ValueError("Please enter an integer greater than 0")

    phi = list(range(n + 1))
    for number in range(2, n + 1):
        if phi[number] == number:
            phi[number] -= 1
            for multiple in range(number * 2, n + 1, number):
                phi[multiple] = (phi[multiple] // number) * (number - 1)

    answer = 1
    for number in range(1, n + 1):
        if (answer / phi[answer]) < (number / phi[number]):
            answer = number

    return answer


if __name__ == "__main__":
    print(solution())
