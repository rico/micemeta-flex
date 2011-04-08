package ch.tofuse.micemeta.utils
{
	import ch.tofuse.micemeta.entities.MouseEntity;

	public class MouseUtils
	{
		public static function mouseLabelFunction( mouse:MouseEntity ):String
		{
			return mouse.id;
		}
	}
}