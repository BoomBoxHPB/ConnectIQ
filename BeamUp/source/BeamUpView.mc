using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class BeamUpView extends Ui.WatchFace {
    var numberSegments = [ [ [ 1, 1, 1, 1, 1 ],
                             [ 1, 0, 0, 0, 1 ],
                             [ 1, 0, 0, 0, 1 ],
                             [ 1, 0, 0, 0, 1 ],
                             [ 1, 1, 1, 1, 1 ] ],
                             
                           [ [ 0, 0, 0, 1, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 0, 0, 0, 0, 1 ] ],
                             
                           [ [ 1, 1, 1, 1, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 1, 1, 1, 1, 1 ],
                             [ 1, 0, 0, 0, 0 ],
                             [ 1, 1, 1, 1, 1 ] ],
                             
                           [ [ 1, 1, 1, 1, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 0, 0, 1, 1, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 1, 1, 1, 1, 1 ] ],
                             
                           [ [ 1, 0, 0, 0, 1 ],
                             [ 1, 0, 0, 0, 1 ],
                             [ 1, 1, 1, 1, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 0, 0, 0, 0, 1 ] ],
                             
                           [ [ 1, 1, 1, 1, 1 ],
                             [ 1, 0, 0, 0, 0 ],
                             [ 1, 1, 1, 1, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 1, 1, 1, 1, 1 ] ],
                             
                           [ [ 1, 1, 1, 1, 1 ],
                             [ 1, 0, 0, 0, 0 ],
                             [ 1, 1, 1, 1, 1 ],
                             [ 1, 0, 0, 0, 1 ],
                             [ 1, 1, 1, 1, 1 ] ],
                             
                           [ [ 1, 1, 1, 1, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 0, 0, 0, 0, 1 ] ],
                             
                           [ [ 1, 1, 1, 1, 1 ],
                             [ 1, 0, 0, 0, 1 ],
                             [ 1, 1, 1, 1, 1 ],
                             [ 1, 0, 0, 0, 1 ],
                             [ 1, 1, 1, 1, 1 ] ],
                             
                           [ [ 1, 1, 1, 1, 1 ],
                             [ 1, 0, 0, 0, 1 ],
                             [ 1, 1, 1, 1, 1 ],
                             [ 0, 0, 0, 0, 1 ],
                             [ 1, 1, 1, 1, 1 ] ] ];
       
    var size = 8;      

    //! Load your resources here
    function onLayout(dc) {
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
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
            for( var j = 0; j < 5; j++ ){
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
    
        var numberH = ( screen_height / 2 ) - ( 4 * size );
        var numberW = ( screen_width / 2 ) - ( 10 * size );
        var runningH = numberH;
        var runningW = numberW;
    
        drawNumber( runningW, runningH, hour / 10, Gfx.COLOR_WHITE, dc );
        runningW += 5.5 * size;
        drawNumber( runningW, runningH, hour % 10, Gfx.COLOR_WHITE, dc );
        runningW += 5.5 * size;
        dc.fillRectangle(runningW, runningH + (2*size), size, size);
        dc.fillRectangle(runningW, runningH + (4*size), size, size);
        runningW += 1.5 * size;
        drawNumber( runningW, runningH, minute / 10, Gfx.COLOR_WHITE, dc );
        runningW += 5.5 * size;
        drawNumber( runningW, runningH, minute % 10, Gfx.COLOR_WHITE, dc );
    
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
