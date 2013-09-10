package com.hprione.factory
{
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	/**
	 * ContextMenuFactory
	 * 
	 * @author hprione
	 * @since 15/04/2011
	 */
	public class ContextMenuFactory
	{
		
		/**
		 * creates and returns a default ContextMenu instance
		 * 
		 * @return returns a default ContextMenu instance
		 */
		public static function defaultContextMenu():ContextMenu
		{
			var contextMenu:ContextMenu = new ContextMenu();
			var link:ContextMenuItem = new ContextMenuItem("hprione.com");
			var email:ContextMenuItem = new ContextMenuItem("hugo@hprione.com");
			
			link.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onLinkItemSelectedHandler);
			email.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onEmailItemSelectedHandler);
			
			contextMenu.hideBuiltInItems();
			contextMenu.customItems.push(new ContextMenuItem("developed by:", false, false));
			contextMenu.customItems.push(link);
			contextMenu.customItems.push(email);
			contextMenu.customItems.push(new ContextMenuItem("+55 34 9174 0658", false, false));
			
			return contextMenu;
		}
		
		/**
		 * opens the link of email of hprione
		 * 
		 * @param	e
		 */
		static private function onEmailItemSelectedHandler(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("mailto:hugo@hprione.com"));
		}
		
		/**
		 * opens the portfolio of hprione
		 * 
		 * @param	e
		 */
		static private function onLinkItemSelectedHandler(e:ContextMenuEvent):void
		{
			navigateToURL(new URLRequest("http://www.hprione.com/"), "_blank");
		}
	}
}