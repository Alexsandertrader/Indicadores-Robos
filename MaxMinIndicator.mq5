//+------------------------------------------------------------------+
//|                                                maximaEminima.mq5 |
//|                                                alexsanderCardoso |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "alexsanderCardoso"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  
//---Calculando a máxima e mínima de um periodo
    {
   MqlRates InformacaoPreco[];
    ArraySetAsSeries(InformacaoPreco,true);
    int Dados = CopyRates(Symbol(),Period(),0,Bars(Symbol(),Period()),InformacaoPreco);
    int NumeroVelas = Bars(Symbol(),Period());
    string NumeroVelasTexto = IntegerToString(NumeroVelas);
   
   // //Calcular o maior e menor numero
   int NumeroMaiorVela = iHighest(NULL,0,MODE_HIGH,50,1);
   int NumeroMenorVela = iLowest(NULL,0,MODE_LOW,50,1);
   

   
   //Calcular o maior e menor preço
   double MaximaPreco = InformacaoPreco[NumeroMaiorVela].high;
    double MinimaPreco = InformacaoPreco[NumeroMenorVela].low;
        
     if(InformacaoPreco[0].low<MinimaPreco)
    {
   
    ObjectCreate(_Symbol,NumeroVelasTexto,OBJ_ARROW_BUY,0,TimeCurrent(),(InformacaoPreco[0].low));
     Comment("Minima: ", MinimaPreco);
    }
    
     if(InformacaoPreco[0].high>MaximaPreco)
    {
   
    ObjectCreate(_Symbol,NumeroVelasTexto,OBJ_ARROW_SELL,0,TimeCurrent(),(InformacaoPreco[0].high));
        Comment(" Maxima: ", MaximaPreco);
      
   }
   
//Vela se aproximando da ultima maxima/minima
    double DistanciaMaxima = MaximaPreco - InformacaoPreco[1].close;
    double DistanciaMinima = MinimaPreco - InformacaoPreco[1].close;
    
    if(DistanciaMaxima <= 0.0006){
    
      //Alert("chegando na maxima :", DistanciaMaxima);
      SetChartColorBackground(clrBlue);
      
    }else if(DistanciaMinima >= -0.0006){
    
      
      //Alert("chegando na minima :", DistanciaMinima);
      SetChartColorBackground(clrBlue);
      
    }else{
    
      SetChartColorBackground(clrBlack);
      
   }
   
  }//fechamento onTick
  
  // mudar a cor do grafco
      void SetChartColorBackground(color BackgroundColor){
      
         ChartSetInteger(_Symbol,CHART_COLOR_BACKGROUND,BackgroundColor);

}
  
//+------------------------------------------------------------------+
