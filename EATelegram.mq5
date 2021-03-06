//+------------------------------------------------------------------+
//|                                                   EATelegram.mq5 |
//|                                                alexsanderCardoso |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "alexsanderCardoso"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Telegram.mqh>
#include <Trade\Trade.mqh>//biblioteca Trade
#include  <Trade/SymbolInfo.mqh>

input group        "Autenticação";
input string token = "";

 
CCustomBot bot;
 
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(5);
   bot.Token(token);
   
   if(bot.GetMe()!=0)
     {
      Print("Erro ao inicializar o robo");
      
      return INIT_FAILED;
     }
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   bot.GetUpdates(); // Obter mensagens
   
   // Processar e enviar mensagens
   for(int i=0; i<bot.ChatsTotal(); i++)
     {
      CCustomChat *chat=bot.m_chats.GetNodeAtIndex(i);
      
      //--- se a mensagem não foi processada
      if(!chat.m_new_one.done)
        {
         chat.m_new_one.done=true;
         string text=chat.m_new_one.message_text;

         //--- início
         if(text=="/start")
            bot.SendMessage(chat.m_id,"Olá! Bem-vindo!");

         //--- ajuda
         if(text=="/update")
            bot.SendMessage(chat.m_id,"A cotação do ativo " + _Symbol + " é: " + DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0));
            
         if(text=="/volume")       
           
            bot.SendMessage(chat.m_id,"Volume Real " + _Symbol + " é: " + DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_REAL), 0)); 

         
        }
     }
}

 