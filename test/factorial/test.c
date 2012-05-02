int factorial(int n)
{
    int i, f;
    for (i=1, f=1; i<=n; i++) {
        f *= i;
    }
    return f;
}

int main()
{
    int x = factorial(5);
    while (1) {
        //do nothing!
    }
    return x;
}
