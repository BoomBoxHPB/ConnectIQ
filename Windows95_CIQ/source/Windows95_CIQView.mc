using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class Windows95_CIQView extends Ui.WatchFace {

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Get and show the current time
		var hour;
		var min;
		var tag;
		
        var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%.2d")]);
        
        var settings = Sys.getDeviceSettings();
        
        //var view = View.findDrawableById("TimeLabel");
        //view.setText(timeString);

		dc.setColor( 0x00AAAA, 0x00AAAA, 0x00AAAA);
		dc.fillRectangle( 0, 0, 205, 148);

		dc.setColor( 0xAAAAAA, 0xAAAAAA, 0xAAAAAA);
		dc.fillRectangle( 0, 120, 205, 148-120);

		dc.setColor(0xFFFFFF, 0xFFFFFF, 0xFFFFFF);
		dc.drawLine(0, 121, 205, 121);
		dc.drawLine(2, 124, 55, 124);
		dc.drawLine(2, 124, 2, 145);
		dc.drawLine(203, 145, 203, 123);
		dc.drawLine(203, 145, 140, 145);
	
		dc.setColor(0x333333, 0x333333, 0x333333);
		dc.drawLine(141, 124, 203, 124);
		dc.drawLine(141, 124, 141, 145);

		dc.setColor(0x000000, 0x000000, 0x000000);
		dc.drawLine(55, 145, 55, 123);
		dc.drawLine(55, 145, 1, 145);

		dc.drawBitmap(21, 2, Ui.loadResource( Rez.Drawables.MyComputer_icon ) );
		dc.drawBitmap(7, 40, Ui.loadResource( Rez.Drawables.MyComputer_text ) );
		dc.drawBitmap(6, 128, Ui.loadResource( Rez.Drawables.Start_button ) );
		
		hour = clockTime.hour;
		min = clockTime.min;

		if( !settings.is24Hour )
			{
			if( hour >= 12 )
				{
				tag = "PM";
				}
			else
				{
				tag = "AM";
				}
			hour = hour % 12;
			hour = ( hour == 0 ) ? 12 : hour;
			}
		else
			{
			tag = "";
			}

		hour = hour.toString();
		min = clockTime.min.format("%02d");
		
		dc.setColor( 0x000000, 0xAAAAAA, 0x000000 );
		dc.drawText( 150, 125, Ui.loadResource( Rez.Fonts.Windows95_font ), hour+":"+min+tag, Graphics.TEXT_JUSTIFY_LEFT );
		
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}