import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;

class NewPauseMenu extends MusicBeatSubstate
{
    var curSelected:Int = 0;

    var pauseMusic:FlxSound;
    var bottomPanel:FlxSprite;
    var continueText:FlxSprite;
    var restartText:FlxSprite;
    var exitText:FlxSprite;

    public function new(x:Float, y:Float) 
    {
        super();
        pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.5;
		bg.scrollFactor.set();
		add(bg);

        bottomPanel = new FlxSprite(550, 30).loadGraphic(Paths.image('pauseStuff/bottomPanel'));
        bottomPanel.scrollFactor.set();
        bottomPanel.scale.set(1.1, 1.1);
        bottomPanel.antialiasing = true;
        bottomPanel.updateHitbox();
        add(bottomPanel);

        continueText = new FlxSprite(0,0).loadGraphic(Paths.image('pauseStuff/Resume'));
        add(continueText);

        restartText = new FlxSprite(0, 0).loadGraphic(Paths.image('pauseStuff/RestartSong'));
        add(restartText);

        exitText = new FlxSprite(980, 0).loadGraphic(Paths.image('pauseStuff/Exittomenu'));
        add(exitText);



        cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
    }

    override function update(elapsed:Float)
    {
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;
        
        super.update(elapsed);

        if(FlxG.keys.justPressed.ESCAPE){
            close();
        }
    }

	override function destroy()
    {
        pauseMusic.destroy();

        super.destroy();
    }

}