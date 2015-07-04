using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class PrideView extends Ui.WatchFace {
    var flag_segment;
    var star_segment_one;
    var star_segment_two;
    
    //! Load your resources here
    function onLayout(dc) {
        flag_segment = Ui.loadResource(Rez.Drawables.FlagSegment);
        star_segment_one = Ui.loadResource(Rez.Drawables.StarSegmentOne);
        star_segment_two = Ui.loadResource(Rez.Drawables.StarSegmentTwo);
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Get and show the current time
        var clockTime = Sys.getClockTime();
        var day = Time.Gregorian.info(Time.now(),0).day;
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
    
        if( hour < 10 ) {
            hour = "0" + hour;
        }
        if( minute < 10 ) {
            minute = "0" + hminuteour;
        }
        if( day < 10 ) {
            day = "0" + day;
        }
        
        
        var x = 5;
        var y = 0;
        
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLUE);
        dc.clear();
        
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_DK_GRAY);
        dc.fillRectangle(0, 0, 11, dc.getHeight());
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_LT_GRAY);
        dc.fillRectangle(2, 0, 7, dc.getHeight());
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
        dc.fillRectangle(4, 0, 3, dc.getHeight());
        
        dc.drawBitmap(x, y, flag_segment );
        dc.drawBitmap(x, y, star_segment_one );
        x += 12;
        dc.drawBitmap(x, y, flag_segment );
        dc.drawBitmap(x, y, star_segment_two );
        x += 12;
        dc.drawBitmap(x, y, flag_segment );
        dc.drawBitmap(x, y, star_segment_one );
        x += 12;
        y += 4;
        dc.drawBitmap(x, y, flag_segment );
        dc.drawBitmap(x, y, star_segment_two );
        x += 12;
        y += 4;
        dc.drawBitmap(x, y, flag_segment );
        dc.drawBitmap(x, y, star_segment_one );
        x += 12;
        y += 4;
        dc.drawBitmap(x, y, flag_segment );
        dc.drawBitmap(x, y, star_segment_two );
        x += 12;
        y += 4;
        dc.drawBitmap(x, y, flag_segment );
        x += 12;
        dc.drawBitmap(x, y, flag_segment );
        x += 12;
        y += -4;
        dc.drawBitmap(x, y, flag_segment );
        x += 12;
        y += -4;
        dc.drawBitmap(x, y, flag_segment );
        x += 12;
        dc.drawBitmap(x, y, flag_segment );
        x += 12;

        x += 6;
        
        
        var two_thirds = (2*dc.getHeight())/3;
        var one_third = dc.getHeight() - two_thirds;
        
        dc.setColor(0x3300AA, 0x3300AA); //Dark Purple
        dc.fillRectangle(x, 0, (dc.getWidth()-x), two_thirds);
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_RED);
        dc.fillRectangle(x, two_thirds, (dc.getWidth()-x), one_third);
        
        x += (dc.getWidth()-x)/2;
        y = 5;
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(x, y, Gfx.FONT_NUMBER_HOT, hour.toString(), Gfx.TEXT_JUSTIFY_CENTER);
        y += 48;
        dc.drawText(x, y, Gfx.FONT_NUMBER_HOT, minute.toString(), Gfx.TEXT_JUSTIFY_CENTER);
        y += 48;
        dc.drawText(x, y, Gfx.FONT_NUMBER_HOT, day.toString(), Gfx.TEXT_JUSTIFY_CENTER);
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
