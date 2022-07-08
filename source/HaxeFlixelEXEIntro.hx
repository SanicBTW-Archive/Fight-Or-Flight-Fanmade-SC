package;

import flixel.addons.transition.FlxTransitionableState;
import vlc.MP4Handler;

class HaxeFlixelEXEIntro extends MusicBeatState
{
    public static var leftState:Bool = false;

    override function create()
    {
        var video:MP4Handler = new MP4Handler();
        video.playVideo(Paths.video("HaxeFlixelIntro"));
        video.finishCallback = function () 
        {
            leftState = true;
            FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
            MusicBeatState.switchState(new TitleState());
            return;
        }
        super.create();
    }
}