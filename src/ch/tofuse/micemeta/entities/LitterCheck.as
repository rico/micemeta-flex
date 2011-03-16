package ch.tofuse.micemeta.entities {

	[RemoteClass(alias="ch.tofuse.micemeta.entities.LitterCheck")]
	[Entity]
	public class LitterCheck extends LitterCheckEntityBase {
		
		public function LitterCheck():void
		{
			super();
			
			this.remark = '';
		}
		
	}

}
