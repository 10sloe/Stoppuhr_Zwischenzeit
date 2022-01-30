class Uhr
{
  private int stunden;
  private int minuten;
  private int sekunden;
  private int zehntel;

  private int x;
  private int y;

  private String anzeige;
  private int radius;
  
  private int startZeit;
  private int vergangeneZeit;
  
  private String zustand;

  Uhr()
  {
    x = 200;
    y = 200;
    radius = 100;
    anzeige = "0:0,0";
    zustand = "zurückgesetzt";
    stunden = 0;
    minuten = 0;
    sekunden = 0;
    zehntel = 0;
  }
  
  void tasteGedrueckt()
  {
    if (zustand.equals("zurückgesetzt"))
    {
      starten();
    }
    else if(zustand.equals("laufend"))
    {
      stoppen();
    }
    else if (zustand.equals("zwischenzeit"))
    {
      vergangeneZeitBerechnen();
      stoppen();
    }
    else
    {
      zuruecksetzen();
    }
  }
  
  void vergangeneZeitBerechnen()
  {
      vergangeneZeit = (millis()-startZeit)/100;   
      zehntel = vergangeneZeit % 10;
      
      int s = vergangeneZeit / 10;
      sekunden = s % 60;
      
      int m = s / 60;
      minuten = m % 60;
      
      stunden = m / 60;
            
      anzeige = stunden + ":" + minuten + ":" + sekunden + "," + zehntel;
  }
  void zGedrueckt()
  {
    if(zustand.equals("laufend"))
    {
      zustand = "zwischenzeit";
    }
    else if(zustand.equals("zwischenzeit"))
    {
      zustand = "laufend";
    }
  }
  
  void starten()
  {
    startZeit = millis();
    println("Die Startzeit ist: " + startZeit);
    zustand = "laufend";
  }
  
  void stoppen()
  {
    zustand = "gestoppt";
  }
  
  void zuruecksetzen()
  {
    anzeige = "0";
    zustand = "zurückgesetzt";
    stunden = 0;
    minuten = 0;
    sekunden = 0;
    zehntel = 0;  
  }

  void aktualisieren()
  {
    if(zustand.equals("laufend"))
    {       
      vergangeneZeitBerechnen();
    }
  }

  void anzeigen()
  {
    // Ziffernblatt
    fill(255);
    strokeWeight(5); // Liniendicke
    stroke(0); 
    circle(x, y, radius*2);
    textAlign(CENTER);
    fill(0);
    textSize(30);
    text(anzeige, x, y - radius - 20);

    // Die Sekundenanzeige
    zeichneSekundenzeiger();
    zeichneMinutenzeiger();
    zeichneStundenzeiger();
    
    circle(x,y,5);
  }

  void zeichneSekundenzeiger()
  {
    float l = radius * 0.8;
    float winkel = sekunden / 60.0 * 2 * PI - PI/2;
    float sx = cos(winkel);
    float sy = sin (winkel);
    stroke(255,0,0);
    strokeWeight(1); // Liniendicke
    line(x, y, x + l*sx, y + l*sy);
  }

  void zeichneMinutenzeiger()
  {
    float l = radius * 0.7;
    float winkel = minuten / 60.0 * 2 * PI - PI/2;
    float sx = cos(winkel);
    float sy = sin (winkel);
    stroke(0);
    strokeWeight(3); // Liniendicke
    line(x, y, x + l*sx, y + l*sy);
  }

  void zeichneStundenzeiger()
  {
    float l = radius * 0.5;
    if (stunden > 12)
    {
      stunden = stunden - 12;
    }
    float winkel = (stunden + minuten/60.0) / 12.0 * 2 * PI - PI/2;
    float sx = cos(winkel);
    float sy = sin (winkel);
    stroke(0);
    strokeWeight(3); // Liniendicke
    line(x, y, x + l*sx, y + l*sy);
  }
}
