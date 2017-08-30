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
    var dashWhite;
    var size;
    var half_height;
    var lowPower = true;
    var screen_height;
    var screen_width;

    // timers - time between frames (approx 12fps @ 80ms)
    var timer_timeout = 50;
    var timer;

    function initialize() {
        WatchFace.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
        screen_height = dc.getHeight();
        screen_width  = dc.getWidth();

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

        dashWhite = Ui.loadResource(Rez.Drawables.DashWhite);

        size = numbersWhite[0].getHeight()  / 5;
        half_height = numbersWhite[0].getHeight()  / 2;
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var date = Time.Gregorian.info(Time.now(),0);
        var stats = Sys.getSystemStats();

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
        var seconds = clockTime.sec;

        dc.setColor(Gfx.COLOR_DK_RED,Gfx.COLOR_DK_RED);

        var numberH = ( screen_height / 2 );

        dc.fillRectangle(0, numberH - (4 * size), screen_width, (8 * size));

        numberH = numberH - half_height;

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

        // Random number (bottom left)
        runningW = numberW - 6 * size;
        runningH = ( numberH + 8 * size ).toLong() % screen_height;
        dc.drawBitmap( runningW, runningH, numbersGray[randomNumber[4]] );
        runningW += size * 6;

        // Battery level (cap at 99%)
        var batt_int = stats.battery.toNumber();
        if( batt_int > 99 ){
            batt_int = 99;
        }
        dc.drawBitmap( runningW, runningH, numbersWhite[batt_int / 10] );
        runningW += size * 6;
        dc.drawBitmap( runningW, runningH, numbersWhite[batt_int % 10] );
        runningW += size * 6;

        // Seconds
        if( !lowPower ){
            dc.drawBitmap( runningW, runningH, numbersWhite[seconds / 10] );
            runningW += size * 6;
            dc.drawBitmap( runningW, runningH, numbersWhite[seconds % 10] );
            runningW += size * 6;
        } else{
            dc.drawBitmap( runningW, runningH, dashWhite );
            runningW += size * 6;
            dc.drawBitmap( runningW, runningH, dashWhite );
            runningW += size * 6;
        }

        // Random number (bottom right)
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

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onPartialUpdate(dc) {
        var clockTime = Sys.getClockTime();
        var seconds = clockTime.sec;


        var numberH = ( screen_height / 2 );

        dc.fillRectangle(0, numberH - (4 * size), screen_width, (8 * size));

        numberH = numberH - half_height;
        var runningH = numberH;
        runningH = ( numberH - 8 * size ).toLong() % screen_height;
        runningH = ( numberH - 8 * size ).toLong() % screen_height;
        var runningW = 128;

        dc.drawBitmap( runningW, runningH, dashWhite );
        runningW += size * 6;
        dc.drawBitmap( runningW, runningH, dashWhite );
        runningW += size * 6;

    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
        lowPower = false;
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
        lowPower = true;
    }

}