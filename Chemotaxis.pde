ArrayList<Bacteria> bacteria = new ArrayList<Bacteria>();
ArrayList<Food> food = new ArrayList<Food>();
void setup()
{
	for (int i = 0; i < 25; i++) {
		bacteria.add(new Bacteria());
		food.add(new Food());
	}
	size(500,500);
	noStroke();
}
void draw()
{
	background(10);
	for (int i = 0; i < bacteria.size(); ++i) {
		if(bacteria.get(i).isDead()){
			bacteria.remove(i);
		}else{bacteria.get(i).tick();}
	}
	for (int i = 0; i < food.size(); ++i) {
		food.get(i).show();
	}
}
class Bacteria
{
	private int x, y;
	private int kcal;
	private int nfx, nfy, nfi;
	int[] myColor = new int[3];
	Bacteria()
	{
		x = (int)(Math.random()*501);
		y = (int)(Math.random()*501);
		kcal = (int)(Math.random()*100+100);
		for (int i = 0; i < 3; i++) {
			myColor[i] = (int)(Math.random()*256);
		}
	}
	void move(){
		int xmove = (int)(Math.random()*10-5);
		int ymove = (int)(Math.random()*10-5);
		if(nfx-x < 0)
		{
			xmove = -1 * Math.abs(xmove);
		}
		else if(nfx-x > 0)
		{
			xmove = Math.abs(xmove);
		}
		if(nfy-y < 0)
		{
			ymove = -1 * Math.abs(ymove);
		}
		else if(nfy-y > 0)
		{
			ymove = Math.abs(ymove);
		}
		if(x + xmove <= 0 || x + xmove >= 500){
			while(xmove <= 0 || xmove >= 500){
				xmove = (int)(Math.random()*10-5);
			}
		}
		if(y + ymove <= 0 || y + ymove >= 500){
			while(ymove <= 0 || ymove >= 500){
				ymove = (int)(Math.random()*10-5);
			}
		}
		x += xmove;
		y += ymove;
	}
	void show()
	{
		fill(myColor[0],myColor[1],myColor[2]);
		ellipse(x, y, 10, 10);
	}
	void tick(){
		getNearestFood(food);
		move();
		show();
		kcal--;
		if(Math.abs(nfx-x) < 5 && Math.abs(nfy-y) < 5)
		{
			kcal += food.get(nfi).getNC();
			food.remove(nfi);
			food.add(new Food());
		}
	}
	boolean isDead()
	{
		return kcal <= 0;
	}
	void getNearestFood(ArrayList<Food> allFood)
	{
		nfi=0;
		int mindist = 500;
		int fd;
		for(int i = 0; i < allFood.size(); i++)
		{
			fd = (int)dist(x, y, allFood.get(i).getX(), allFood.get(i).getY());

			if(fd < mindist)
			{
				mindist = fd;
				nfi = i;
			}
			
		}
		nfx = allFood.get(nfi).getX();
		nfy = allFood.get(nfi).getY();
	}
}
class Food
{
	private int x, y, nc;
	Food () {
		x = (int)(Math.random()*501);
		y = (int)(Math.random()*501);
		nc = (int)(Math.random()*100+100);
	}

	void show()
	{
		fill(115, 90, 40);
		ellipse(x, y, (int)(Math.random()*(nc/100)+4), (int)(Math.random()*(nc/100)+4));
	}

	int getX()
	{
		return x;
	}
	int getY()
	{
		return y;
	}
	int getNC(){
		return nc;
	}

}