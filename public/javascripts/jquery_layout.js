/**
 * @author rudy-206115574
 */
		j = jQuery.noConflict();
		xx = j('.ex');
		//jQuery('.item').hide();
		jQuery('div.item').children('div').addClass('item_row');
		jQuery('div.edit>div').addClass('row');
		
		j('#photolink').click(function(event){
			event.preventDefault();
			j('#resume_photo').click()
			//:file[id2^=photof]
		});
		j('#resume_photo').click(function(event){
			//:file[id2^=photof]
			//:style=>'display:none;',
		});


		jQuery('div.item_row:even').addClass('even');
		jQuery('div.item_row:odd').addClass('odd');
				
		row = j('.row');
		row.each(function(){
			j(this).children("div:eq(0)").addClass('row_label');
			j(this).children("div:eq(1)").addClass('row_content');
		});
		row.filter(':even').addClass('even');
		row.filter(':odd').addClass('odd');
		j('.list').find('tbody tr:even').addClass('even');
		j('.list').find('tbody tr:odd').addClass('odd');
		j('.list').find('thead tr:eq(1)').addClass('thead');
		
		j('.accordion').each(function(){
			var $this = j(this);
			$this.click(function(){
				var nextdiv = $this.next('div.item,div.ex');
				
				if (nextdiv.is(':hidden')) {
					nextdiv.show();
				}
				else {
					nextdiv.hide();
				}
			})
			$this.next('div.item:not(.exc)').hide();
		});
		
		