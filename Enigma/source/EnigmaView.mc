using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Math as Math;
using Toybox.Timer as Timer;

class EnigmaView extends Ui.WatchFace {
    var numbersWhite = new [10];
    var numbersGray = new [10];
    var randomNumber = new [18];
    var size;
    var offset_array = [0.0, 0.5, 0.15, 0.25, 0.35, 0.50, 0.65, 0.75, 0.85, 0.95];
    var offset_idx = 0;
    var half_height;

    // timers - time between frames (approx 12fps @ 80ms)
    var timer_timeout = 50;
    var timer;

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
        half_height = numbersWhite[0].getHeight()  / 2;
        offset_idx = 0;
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

        var numberH = ( screen_height / 2 );

        dc.fillRectangle(0, numberH - (4 * size), screen_width, (8 * size));

        numberH += ( ( screen_height * offset_array[offset_idx] ) - half_height );
        numberH = numberH.toLong() % screen_height;
        var numberW = ( screen_width / 2 ) - ( 10.5 * size );
        var runningH = numberH;
        var runningW = numberW;


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
        runningH = ( numberH - 8 * size ).toLong() % screen_height;
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
        runningH = ( numberH + 8 * size ).toLong() % screen_height;
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
        runningH = ( numberH - 16 * size ).toLong() % screen_height;
        if( ( runningH + 35 ) >= 0 ){
            dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[6]] );

            for( var i=0; i<5; i++ ){
                runningW += 6 * size;
                dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[7+i]] );
            }
        }

        // LOWER RANDOM NUMBERS!
        runningW = numberW - 6 * size;
        runningH = ( numberH + 16 * size ).toLong() % screen_height;
        if( runningH <= screen_height ){
            dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[12]] );

            for( var i=0; i<5; i++ ){
                runningW += 6 * size;
                dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[13+i]] );
            }
        }
    }

    function callback_animate() {
        // redraw the screen
        Ui.requestUpdate();

        offset_idx++;
        offset_idx = offset_idx % 10;

        // timer not greater than 500ms? then let's start the timer again
        //if( timer_timeout < 500 ) {
            timer = new Timer.Timer();
            timer.start(method(:callback_animate), timer_timeout, false );
        //} else {
        //    // timer exists? stop it
        //    if( timer ) {
        //        timer.stop();
        //    }
        //}
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
        // let's start our animation loop
        timer = new Timer.Timer();
        timer.start(method(:callback_animate), timer_timeout, false );
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
        if( timer ) {
            timer.stop();
        }

        timer_timeout = 50;
        offset_idx = 0;
    }

}