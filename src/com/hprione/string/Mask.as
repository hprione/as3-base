﻿/**
 * Mask
 *
 * @author Wagner Brandão Soares
 *
 * @langversion 3.0
 */
package com.hprione.string
{
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	public class Mask
	{
		private var obj:TextField;
		private var mascara:String;
		private var charMap:Object = { num:"[0-9]", char:"[A-Za-z]", all:"[A-Za-z0-9]" };
		
		public function Mask(obj:TextField, mascara:String = "")
		{
			this.obj = obj;
			this.obj.addEventListener(TextEvent.TEXT_INPUT, this.tecla);
			this.mascara = mascara;
		}
		
		public function unload():void
		{
			obj.removeEventListener(TextEvent.TEXT_INPUT, this.tecla);
			obj = null;
		}
		
		private function setCaretPosition(pos:int):void
		{
			this.obj.setSelection(pos, pos);
		}
		
		private function tecla(ev:TextEvent):void
		{
			var key:uint = ev.text.charCodeAt(0);
			var char:String = ev.text;
			var texto:Array = new Array(this.mascara.length);
			var pos:int = this.obj.selectionBeginIndex;
			var igual:Object = null;
			var reChar:RegExp;
			
			for(var i:int = 0;i < texto.length; i++)
			{
				if(this.obj.text.length < i) texto[i] = "";
				else texto[i] = this.obj.text.charAt(i);
			}
			
			if(key >= 48 && key <= 122)
			{//typeable characters
				while(pos < this.mascara.length)
				{
					// verifica se o caracter na posicao do cursor é um elemento da máscara
					if(this.mascara.charAt(pos) != "9" && this.mascara.charAt(pos) != "a" && this.mascara.charAt(pos) != "*")
					{// se for um elemento da mascara, adiciona o mesmo no texto e passa para a próxima posição
						texto[pos]=this.mascara.charAt(pos);
						pos++;
						continue;
					}
					else
					{// se não for um caracter da mascara, verifica se o mesmo é permitido
						switch(this.mascara.charAt(pos))
						{
							case "9":
								reChar = new RegExp(charMap.num);
								break;
							case "a":
								reChar = new RegExp(charMap.char);
								break;
							case "*":
								reChar = new RegExp(charMap.all);
								break;
							default:break;
						}
						
						igual= reChar.exec(char);
						
						if(igual)
						{
							texto[pos]=char;
							pos++;
						}
						break;
					}					
				}
				// devolve o texto para o input
				this.obj.text = texto.join("");
				// seta a nova posição do cursor
				setCaretPosition(pos);
				ev.preventDefault();
			}
			else ev.preventDefault();
		}
	}
}