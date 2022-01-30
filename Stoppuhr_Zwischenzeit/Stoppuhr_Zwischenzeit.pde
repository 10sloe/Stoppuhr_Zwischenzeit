Uhr uhr;

void setup()
{
  size(400,400);
  uhr = new Uhr();
}

void draw()
{
  background(200);
  uhr.aktualisieren();
  uhr.anzeigen(); 
}

void keyPressed()
{
  if(key == ' ')
  {
    uhr.tasteGedrueckt();
  }
  if(key == 'z')
  {
    uhr.zGedrueckt();
  }
}
