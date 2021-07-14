time -= Time.deltaTime;
if (time <= 0.0)
{
	alpha -= Time.deltaTime;
}
if (alpha <= 0.0)
{
	idelete(this);
}