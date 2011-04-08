package ch.tofuse.micemeta.entities {
	[RemoteClass(alias="ch.tofuse.micemeta.entities.LitterCheckEntity")]
	[Entity]
	public class LitterCheckEntity extends LitterCheckEntityEntityBase {
		
		public function LitterCheckEntity():void
		{
			super();
			
			this.remark = '';
		}
		
	}

}
