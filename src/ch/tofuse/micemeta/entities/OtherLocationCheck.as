package ch.tofuse.micemeta.entities {

	[RemoteClass(alias="ch.tofuse.micemeta.entities.OtherLocationCheck")]
	[Entity]
	public class OtherLocationCheck extends OtherLocationCheckEntityBase {
	
		public function OtherLocationCheck():void
		{
			super();
			
			this.non_transpondered = 0;
			this.sub_adults = 0;
			this.pups = 0;
			this.pups_age = 0;
			this.pups_male_alive = 0;
			this.pups_male_dead = 0;
			this.pups_female_alive = 0;
			this.pups_female_dead = 0;
			this.pups_unknown_alive = 0;
			this.pups_unknown_dead = 0;
			this.new_litter = false;
			this.communal = false;
			this.remark = '';
			
		}
	}

}
