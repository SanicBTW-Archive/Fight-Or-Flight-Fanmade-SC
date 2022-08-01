import flixel.math.FlxMath;
import flixel.FlxCamera;
import sys.FileSystem;
import sys.io.File;
import lime.system.System;
import haxe.io.Path;
import flixel.FlxG;
import flixel.FlxSprite;

class TestState extends MusicBeatState
{
    static var RequiredPath:String = Path.join([System.userDirectory, 'sanicbtw_fofR']);
    static var CoordsPath:String = Path.join([RequiredPath, 'coords.txt']);
    static var temp:String = "fofStage|0, -150, 1, 2";
    var fofStage:FlxSprite;
    var coords:Map<String, Array<String>> = new Map<String, Array<String>>();
    var cityBG:FlxSprite;
    var lightBG:FlxSprite;
    var sonicDead:FlxSprite;
    var towerBG:FlxSprite;
    var camGame:FlxCamera;
    var defaultCamZoom:Float = 1;
    override function create()
    {
        if(!FileSystem.exists(RequiredPath)){
            FileSystem.createDirectory(RequiredPath);
        }
        if(!FileSystem.exists(CoordsPath)){
            File.saveContent(CoordsPath, temp);
        }

        camGame = new FlxCamera();
        FlxG.cameras.reset(camGame);
        FlxCamera.defaultCameras = [camGame];

        var the = File.getContent(CoordsPath);
        var fix = the.split("\n");
        for(i in 0...fix.length)
        {
            var item:Array<String> = fix[i].split("|");
            for(j in 0...item.length)
            {
                coords.set(item[0], item[j].split(","));
            }
        }

        cityBG = new FlxSprite(Std.parseFloat(coords.get('cityBG')[0]), Std.parseFloat(coords.get('cityBG')[1]), Paths.image('starved/city'));
        cityBG.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
        cityBG.scale.set(Std.parseFloat(coords.get('cityBG')[2]), Std.parseFloat(coords.get('cityBG')[3]));
        cityBG.scrollFactor.set();
        cityBG.antialiasing = ClientPrefs.globalAntialiasing;
        cityBG.updateHitbox();
        add(cityBG);

        towerBG = new FlxSprite(Std.parseFloat(coords.get('towerBG')[0]), Std.parseFloat(coords.get('towerBG')[1]), Paths.image('starved/towers'));
        towerBG.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
        towerBG.scale.set(Std.parseFloat(coords.get('towerBG')[2]), Std.parseFloat(coords.get('towerBG')[3]));
        towerBG.scrollFactor.set();
        towerBG.antialiasing = ClientPrefs.globalAntialiasing;
        towerBG.updateHitbox();
        add(towerBG);

        fofStage = new FlxSprite(Std.parseFloat(coords.get('fofStage')[0]), Std.parseFloat(coords.get('fofStage')[1]), Paths.image('starved/stage'));
        fofStage.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
        fofStage.scale.set(Std.parseFloat(coords.get('fofStage')[2]), Std.parseFloat(coords.get('fofStage')[3]));
        fofStage.scrollFactor.set();
        fofStage.antialiasing = ClientPrefs.globalAntialiasing;
        fofStage.updateHitbox();
        add(fofStage);

        sonicDead = new FlxSprite(Std.parseFloat(coords.get('sonic')[0]), Std.parseFloat(coords.get('sonic')[1]), Paths.image('starved/sonicisfuckingdead'));
        sonicDead.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
        sonicDead.scale.set(Std.parseFloat(coords.get('sonic')[2]), Std.parseFloat(coords.get('sonic')[3]));
        sonicDead.scrollFactor.set();
        sonicDead.antialiasing = ClientPrefs.globalAntialiasing;
        sonicDead.updateHitbox();
        add(sonicDead);

        lightBG = new FlxSprite(Std.parseFloat(coords.get('lights')[0]), Std.parseFloat(coords.get('lights')[1]), Paths.image('starved/light'));
        lightBG.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
        lightBG.scale.set(Std.parseFloat(coords.get('lights')[2]), Std.parseFloat(coords.get('lights')[3]));
        lightBG.scrollFactor.set();
        lightBG.antialiasing = ClientPrefs.globalAntialiasing;
        lightBG.updateHitbox();
        add(lightBG);
    
        super.create();
    }

    override function update(elapsed:Float)
    {
        if(FlxG.keys.justPressed.R){
            FlxG.resetState();
        }

        FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, CoolUtil.boundTo(1 - (elapsed * 3.125), 0, 1));

        if(FlxG.keys.justPressed.P){
            defaultCamZoom = 0.85;
        }
        if(FlxG.keys.justPressed.O){
            defaultCamZoom = 1;
        }

        super.update(elapsed);
    }
}