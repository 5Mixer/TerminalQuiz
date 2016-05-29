package ;

import haxe.io.Eof;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;


class Quiz {
	public var questions:Array<Question>;
	var stdin  = Sys.stdin();

	public function new (){
		questions = new Array<Question>();
		load("questions.qa");
		test();

	}
	public function load (fname){
		var fin = File.read( fname, false );
		try {
			while( true ) {
				var str = fin.readLine();
				var q = str.split(":")[0];
				var a = StringTools.trim(str.split(":")[1]);
				questions.push(new Question(q,a));
			}
		}
		catch( ex:haxe.io.Eof )
		{

		}
		fin.close();

	}


	public function test (){

		var quit = false;
		while (quit == false){
			var q = questions[Math.floor(Math.random()*questions.length)];

			var correct = false;
			while (!correct){
				correct = askQuestion(q);
				if (correct){
					break;
				} else{
					Sys.print("\nIncorrect, try again.\n\n");

				}
			}
			Sys.print("Correct!\n\n");
		}
	}
	public function askQuestion(q:Question){
		Sys.print(q.question + "\n\n");

		var input = "";
		while (true){
			var newChar = Sys.getChar(false);
			input += String.fromCharCode(newChar);
			if (newChar == 13){
				break;
			}else if (newChar == 3 || newChar == 27){ //Control-C and escape close.
				Sys.exit(0);
			}else{
				Sys.print(String.fromCharCode(newChar));
			}
		}



		var a = input;
		Sys.print("\n");
		input = "";

		if (StringTools.trim(a) == q.answer){
			return true;
		}
		return false;
	}
}
