package;

import flixel.addons.transition.FlxTransitionableState;
import FlxVideo;

class HaxeFlixelEXEIntro extends MusicBeatState
{
    public static var leftState:Bool = false;

    override function create()
    {
        (new FlxVideo(Paths.video("HaxeFlixelIntro"))).finishCallback = function() {
            leftState = true;
            FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
            MusicBeatState.switchState(new TitleState());
        }
        super.create();
    }
}