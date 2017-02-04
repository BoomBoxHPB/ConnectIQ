using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Math as Math;

class EnigmaView extends Ui.WatchFace {
	var numbersWhite = new [10];
	var numbersGray = new [10];
    var randomNumber = new [18];
    var size;
	
    function initialize() {
        WatchFace.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
        for( var i = 0; i < 18; i++ ) {
            randomNumber[i] = Math.rand() % 10;
        }
    	numbersWhite[0] = Ui.loadResource(Rez.Drawables.ZeroWhite);
    	numbersWhite[1] = Ui.loadResource(Rez.Drawables.OneWhite);
    	numbersWhite[2] = Ui.loadResource(Rez.Drawables.TwoWhite);
    	numbersWhite[3] = Ui.loadResource(Rez.Drawables.ThreeWhite);
    	numbersWhite[4] = Ui.loadResource(Rez.Drawables.FourWhite);
    	numbersWhite[5] = Ui.loadResource(Rez.Drawables.FiveWhite);
    	numbersWhite[6] = Ui.loadResource(Rez.Drawables.SixWhite);
    	numbersWhite[7] = Ui.loadResource(Rez.Drawables.SevenWhite);
    	numbersWhite[8] = Ui.loadResource(Rez.Drawables.EightWhite);
    	numbersWhite[9] = Ui.loadResource(Rez.Drawables.NineWhite);

    	numbersGray[0] = Ui.loadResource(Rez.Drawables.ZeroGray);
    	numbersGray[1] = Ui.loadResource(Rez.Drawables.OneGray);
    	numbersGray[2] = Ui.loadResource(Rez.Drawables.TwoGray);
    	numbersGray[3] = Ui.loadResource(Rez.Drawables.ThreeGray);
    	numbersGray[4] = Ui.loadResource(Rez.Drawables.FourGray);
    	numbersGray[5] = Ui.loadResource(Rez.Drawables.FiveGray);
    	numbersGray[6] = Ui.loadResource(Rez.Drawables.SixGray);
    	numbersGray[7] = Ui.loadResource(Rez.Drawables.SevenGray);
    	numbersGray[8] = Ui.loadResource(Rez.Drawables.EightGray);
    	numbersGray[9] = Ui.loadResource(Rez.Drawables.NineGray);
    	
    	size = numbersWhite[0].getHeight()  / 5;
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var date = Time.Gregorian.info(Time.now(),0);
        
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        
        var hour = clockTime.hour;
        //12-hour support
        if (hour > 12 || hour == 0)
            {
            var deviceSettings = Sys.getDeviceSettings();
            if (!deviceSettings.is24Hour)
                {
                if (hour == 0) 
                    {
                    hour = 12;
                    }
                else 
                    {
                    hour = hour - 12;
                    }
                }
            }
            
        var minute = clockTime.min;
        
        var screen_height = dc.getHeight();
        var screen_width  = dc.getWidth();
        
        dc.setColor(Gfx.COLOR_DK_RED,Gfx.COLOR_DK_RED);

        var numberH = ( screen_height / 2 ) - ( 2.5 * size );
        var numberW = ( screen_width / 2 ) - ( 10.5 * size );
        var runningH = numberH;
        var runningW = numberW;
        
        dc.fillRectangle(0, numberH - (1.5 * size), screen_width, (8 * size));
        
        // TIME!
        runningW -= 6 * size;
        dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[0]] );
        runningW += 6 * size;
        dc.drawBitmap( runningW, runningH, numbersWhite[hour / 10] );
        runningW += 6 * size;
        dc.drawBitmap( runningW, runningH, numbersWhite[hour % 10] );
        runningW += 6 * size;
        dc.drawBitmap( runningW, runningH, numbersWhite[minute / 10] );
        runningW += 6 * size;
        dc.drawBitmap( runningW, runningH, numbersWhite[minute % 10] );
        runningW += 6 * size;
        dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[1]] );

        // DATE!
        runningW = numberW - 6 * size;
        runningH = numberH - 8 * size;
        dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[2]] );
        runningW += 6 * size;
        dc.drawBitmap( runningW, runningH, numbersWhite[date.month / 10] );
        runningW += 6 * size;
        dc.drawBitmap( runningW, runningH, numbersWhite[date.month % 10] );
        runningW += 6 * size;
        dc.drawBitmap( runningW, runningH, numbersWhite[date.day / 10] );
        runningW += 6 * size;
        dc.drawBitmap( runningW, runningH, numbersWhite[date.day % 10] );
        runningW += 6 * size;
        dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[3]] );

        runningW = numberW - 6 * size;
        runningH = numberH + 8 * size;
        dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[4]] );
        runningW += size * 6;
        dc.drawBitmap( runningW, runningH, numbersWhite[date.year / 1000] );
        runningW += size * 6;
        dc.drawBitmap( runningW, runningH, numbersWhite[( date.year % 1000 ) / 100] );
        runningW += size * 6;
        dc.drawBitmap( runningW, runningH, numbersWhite[( date.year % 100 ) / 10] );
        runningW += size * 6;
        dc.drawBitmap( runningW, runningH, numbersWhite[date.year % 10] );
        runningW += size * 6;
        dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[5]] );

        // UPPER RANDOM NUMBERS!
        runningW = numberW - 6 * size;
        runningH = numberH - 16 * size;
        if( ( runningH + 35 ) >= 0 ){
	        dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[6]] );
	        
	        for( var i=0; i<5; i++ ){
	            runningW += 6 * size;
	            dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[7+i]] );
	        }
        }
        
        // LOWER RANDOM NUMBERS!
        runningW = numberW - 6 * size;
        runningH = numberH + 16 * size;
        if( runningH <= screen_height ){
	        dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[12]] );
	        
	        for( var i=0; i<5; i++ ){
	            runningW += 6 * size;
	            dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[13+i]] );
	        }
        }
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}