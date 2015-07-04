using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Math as Math;

class EnigmaView extends Ui.WatchFace {
    var numberSegments = [ [ [ 1, 1, 1 ],
                             [ 1, 0, 1 ],
                             [ 1, 0, 1 ],
                             [ 1, 0, 1 ],
                             [ 1, 1, 1 ] ],
                             
                           [ [ 1, 1, 0 ],
                             [ 0, 1, 0 ],
                             [ 0, 1, 0 ],
                             [ 0, 1, 0 ],
                             [ 1, 1, 1 ] ],
                             
                           [ [ 1, 1, 1 ],
                             [ 0, 0, 1 ],
                             [ 1, 1, 1 ],
                             [ 1, 0, 0 ],
                             [ 1, 1, 1 ] ],
                             
                           [ [ 1, 1, 1 ],
                             [ 0, 0, 1 ],
                             [ 0, 1, 1 ],
                             [ 0, 0, 1 ],
                             [ 1, 1, 1 ] ],
                             
                           [ [ 1, 0, 1 ],
                             [ 1, 0, 1 ],
                             [ 1, 1, 1 ],
                             [ 0, 0, 1 ],
                             [ 0, 0, 1 ] ],
                             
                           [ [ 1, 1, 1 ],
                             [ 1, 0, 0 ],
                             [ 1, 1, 1 ],
                             [ 0, 0, 1 ],
                             [ 1, 1, 1 ] ],
                             
                           [ [ 1, 1, 1 ],
                             [ 1, 0, 0 ],
                             [ 1, 1, 1 ],
                             [ 1, 0, 1 ],
                             [ 1, 1, 1 ] ],
                             
                           [ [ 1, 1, 1 ],
                             [ 1, 0, 1 ],
                             [ 0, 0, 1 ],
                             [ 0, 0, 1 ],
                             [ 0, 0, 1 ] ],
                             
                           [ [ 1, 1, 1 ],
                             [ 1, 0, 1 ],
                             [ 1, 1, 1 ],
                             [ 1, 0, 1 ],
                             [ 1, 1, 1 ] ],
                             
                           [ [ 1, 1, 1 ],
                             [ 1, 0, 1 ],
                             [ 1, 1, 1 ],
                             [ 0, 0, 1 ],
                             [ 1, 1, 1 ] ] ];
       
    var size = 6;      
    var randomNumber = new [18];

    //! Load your resources here
    function onLayout(dc) {
        for( var i = 0; i < 18; i++ ) {
            randomNumber[i] = Math.rand() % 10;
        }
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    function drawNumber( x, y, number, color, dc ) {
        var old_x = x;
        var segments;
        dc.setColor( color, color );
        
        if( number < 0 || number > 9 ) {
            return;
        }
        
        segments = numberSegments[number];
        
        for( var i = 0; i < 5; i++ ){
            for( var j = 0; j < 3; j++ ){
                if( segments[i][j] == 1 ) {
                    dc.fillRectangle(x, y, size, size);
                }
                
                x = x + size;
            }
        
            y = y + size;
            x = old_x;
        }
        
    }

    //! Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var day= Time.Gregorian.info(Time.now(),0);
        
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
        drawNumber( runningW, runningH, randomNumber[0], Gfx.COLOR_DK_GRAY, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, hour / 10, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, hour % 10, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, minute / 10, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, minute % 10, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, randomNumber[1], Gfx.COLOR_DK_GRAY, dc );

        // DATE!
        runningW = numberW - 6 * size;
        runningH = numberH - 8 * size;
        drawNumber( runningW, runningH, randomNumber[2], Gfx.COLOR_DK_GRAY, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, date.month / 10, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, date.month % 10, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, date.day / 10, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, date.day % 10, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, randomNumber[3], Gfx.COLOR_DK_GRAY, dc );

        runningW = numberW - 6 * size;
        runningH = numberH + 8 * size;
        drawNumber( runningW, runningH, randomNumber[4], Gfx.COLOR_DK_GRAY, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, date.year / 1000, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, ( date.year % 1000 ) / 100, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, ( date.year % 100 ) / 10, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, date.year % 10, Gfx.COLOR_WHITE, dc );
        runningW += 6 * size;
        drawNumber( runningW, runningH, randomNumber[5], Gfx.COLOR_DK_GRAY, dc );

        // UPPER RANDOM NUMBERS!
        runningW = numberW - 6 * size;
        runningH = numberH - 16 * size;
        if( ( runningH + 35 ) >= 0 ){
	        drawNumber( runningW, runningH, randomNumber[6], Gfx.COLOR_DK_GRAY, dc );
	        
	        for( var i=0; i<5; i++ ){
	            runningW += 6 * size;
	            drawNumber( runningW, runningH, randomNumber[7+i], Gfx.COLOR_DK_GRAY, dc );
	        }
        }
        
        // LOWER RANDOM NUMBERS!
        runningW = numberW - 6 * size;
        runningH = numberH + 16 * size;
        if( runningH <= screen_height ){
	        drawNumber( runningW, runningH, randomNumber[12], Gfx.COLOR_DK_GRAY, dc );
	        
	        for( var i=0; i<5; i++ ){
	            runningW += 6 * size;
	            drawNumber( runningW, runningH, randomNumber[13+i], Gfx.COLOR_DK_GRAY, dc );
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