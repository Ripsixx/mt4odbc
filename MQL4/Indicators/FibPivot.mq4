//+------------------------------------------------------------------+
//|                                                        Pivot.mq4 |
//|                               Copyright © 2004, Poul_Trade_Forum |
//|                                                         Aborigen |
//|                                          http://forex.kbpauk.ru/ |
//+------------------------------------------------------------------+
#property copyright "Poul Trade Forum"
#property link      "http://forex.kbpauk.ru/"

#property indicator_chart_window
//#property indicator_separate_window
#property indicator_buffers 9
#property indicator_color1 Yellow
#property indicator_color2 Yellow
#property indicator_color3 Yellow
#property indicator_color4 Yellow
#property indicator_color5 Yellow
#property indicator_color6 Yellow
#property indicator_color7 Yellow
#property indicator_color8 Yellow
#property indicator_color9 Orange
//---- input parameters

//---- buffers
double PBuffer[];
double S1Buffer[];
double R1Buffer[];
double S2Buffer[];
double R2Buffer[];
double S3Buffer[];
double R3Buffer[];
double S4Buffer[];
double R4Buffer[];
string Pivot="Pivot Point",Sup1="S 1", Res1="R 1"; 
string Sup2="S 2", Res2="R 2", Sup3="S 3", Res3="R 3", Res4="R 4", Sup4="S 4";
int fontsize=10;
double P,S1,R1,S2,R2,S3,R3,S4,R4;
double LastHigh,LastLow,x;

//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//---- TODO: add your code here

   ObjectDelete("Pivot");
   ObjectDelete("Sup1");
   ObjectDelete("Res1");
   ObjectDelete("Sup2");
   ObjectDelete("Res2");
   ObjectDelete("Sup3");
   ObjectDelete("Res3");   
   ObjectDelete("Sup4");
   ObjectDelete("Res4");   

//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   string short_name;


//---- indicator line
   SetIndexStyle(0,DRAW_LINE,0,1,Yellow);
   SetIndexStyle(1,DRAW_LINE,0,1,Yellow);
   SetIndexStyle(2,DRAW_LINE,0,1,Yellow);
   SetIndexStyle(3,DRAW_LINE,0,1,Orange);
   SetIndexStyle(4,DRAW_LINE,0,1,Yellow);
   SetIndexStyle(5,DRAW_LINE,0,1,Yellow);
   SetIndexStyle(6,DRAW_LINE,0,1,Yellow);
   SetIndexStyle(7,DRAW_LINE,0,1,Orange);
   SetIndexStyle(8,DRAW_LINE,0,2,Orange);
  
   SetIndexBuffer(0,S1Buffer);
   SetIndexBuffer(1,S2Buffer);
   SetIndexBuffer(2,S3Buffer);
   SetIndexBuffer(3,S4Buffer);
   SetIndexBuffer(4,R1Buffer);
   SetIndexBuffer(5,R2Buffer);
   SetIndexBuffer(6,R3Buffer);
   SetIndexBuffer(7,R4Buffer);
   SetIndexBuffer(8,PBuffer);


//---- name for DataWindow and indicator subwindow label
   short_name="Pivot Point";
   IndicatorShortName(short_name);
   SetIndexLabel(0,short_name);

//----
   SetIndexDrawBegin(0,1);
//----
 

//----
   return(0);
  }

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()

  {
   int    counted_bars=IndicatorCounted();

   int limit, i;
//---- indicator calculation
if (counted_bars==0)
{
   x=Period();
   if (x>240) return(-1);
   ObjectCreate("Pivot", OBJ_TEXT, 0, 0,0);
   ObjectSetText("Pivot", "                 Pivot Point",fontsize,"Arial",Red);
   ObjectCreate("Sup1", OBJ_TEXT, 0, 0, 0);
   ObjectSetText("Sup1", "      S 1",fontsize,"Arial",Red);
   ObjectCreate("Res1", OBJ_TEXT, 0, 0, 0);
   ObjectSetText("Res1", "      R 1",fontsize,"Arial",Red);
   ObjectCreate("Sup2", OBJ_TEXT, 0, 0, 0);
   ObjectSetText("Sup2", "      S 2",fontsize,"Arial",Red);
   ObjectCreate("Res2", OBJ_TEXT, 0, 0, 0);
   ObjectSetText("Res2", "      R 2",fontsize,"Arial",Red);
   ObjectCreate("Sup3", OBJ_TEXT, 0, 0, 0);
   ObjectSetText("Sup3", "      S 3",fontsize,"Arial",Red);
   ObjectCreate("Res3", OBJ_TEXT, 0, 0, 0);
   ObjectSetText("Res3", "      R 3",fontsize,"Arial",Red);
   ObjectCreate("Sup4", OBJ_TEXT, 0, 0, 0);
   ObjectSetText("Sup4", "      S 4",fontsize,"Arial",Red);
   ObjectCreate("Res4", OBJ_TEXT, 0, 0, 0);
   ObjectSetText("Res4", "      R 4",fontsize,"Arial",Red);
   
}
   if(counted_bars<0) return(-1);
//---- last counted bar will be recounted
//   if(counted_bars>0) counted_bars--;
   limit=(Bars-counted_bars)-1;



for (i=limit; i>=0;i--)
{ 

if (High[i+1]>LastHigh) LastHigh=High[i+1];
if (Low[i+1]<LastLow) LastLow=Low[i+1];

if (TimeDay(Time[i])!=TimeDay(Time[i+1]))
   { 
   P=(LastHigh+LastLow+Close[i+1])/3;
   R1 = P+(LastHigh - LastLow)*0.5;
   R2 = P+(LastHigh - LastLow)*0.618;
   R3 = P+(LastHigh - LastLow);
   R4 = P+(LastHigh - LastLow)*1.382;
   S1 = P-(LastHigh - LastLow)*0.5;
   S2 = P-(LastHigh - LastLow)*0.618;
   S3 = P-(LastHigh - LastLow);
   S4 = P-(LastHigh - LastLow)*1.382;

   LastLow=Open[i]; LastHigh=Open[i];

   ObjectMove("Pivot", 0, Time[i],P);
   ObjectMove("Sup1", 0, Time[i],S1);
   ObjectMove("Res1", 0, Time[i],R1);
   ObjectMove("Sup2", 0, Time[i],S2);
   ObjectMove("Res2", 0, Time[i],R2);
   ObjectMove("Sup3", 0, Time[i],S3);
   ObjectMove("Res3", 0, Time[i],R3);
   ObjectMove("Sup4", 0, Time[i],S4);
   ObjectMove("Res4", 0, Time[i],R4);

   }
   
    PBuffer[i]=P;
    S1Buffer[i]=S1;
    R1Buffer[i]=R1;
    S2Buffer[i]=S2;
    R2Buffer[i]=R2;
    S3Buffer[i]=S3;
    R3Buffer[i]=R3;
    S4Buffer[i]=S4;
    R4Buffer[i]=R4;

}

//----
   return(0);
  }
//+------------------------------------------------------------------+