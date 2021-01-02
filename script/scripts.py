from subprocess import check_call


def lint() -> None:
    check_call(["flake8", "--config=setup.cfg", "competitions"])


def format() -> None:
    check_call(["isort", "competitions"])
    check_call(["black", "competitions"])
