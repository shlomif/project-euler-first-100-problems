public class Problem78 {
	static int[] p = new int[1000000];

	static int penta(int n){
		return n*(3*n -1)/2;
	}

	static int sign(int k){
		return (k+1 & 2) - 1;
	}

	public static void main(String[] args){
		p[0] = 1;
		int n = 1;
		while(p[n-1]%1000000 != 0){
			int x = 1;
			int i = 1;
			p[n] = 0;

			while(penta(x) <= n){
				p[n] = p[n] + p[n - penta(x)]*sign(i);
				p[n] = p[n] % 1000000;
				if(x > 0) x = -x;
				else x = (-x) + 1;
				i++;
			}
			n++;
		}
		System.out.println(n-1);
	}
}
