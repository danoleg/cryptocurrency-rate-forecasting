Class DATA.BitcoinRates Extends (%Persistent, %XML.Adaptor)
{

/// Class of travel
Property Date As %Datetime;

/// Survived or not
Property Rate As %Float;


Storage Default
{
<Data name="PassengerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Date</Value>
</Value>
<Value name="3">
<Value>Rate</Value>
</Value>

</Data>
<DataLocation>^DATA.BitcoinRatesD</DataLocation>
<DefaultData>BitcoinRatesDefaultData</DefaultData>
<IdLocation>^DATA.BitcoinRatesId</IdLocation>
<IndexLocation>^DATA.BitcoinRatesI</IndexLocation>
<StreamLocation>^DATA.BitcoinRatesS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

/// Gratefully copied from 
ClassMethod Import() As %Status
{
	#dim sc As %Status = $$$OK
	set xdata = ##class(%Dictionary.XDataDefinition).IDKEYOpen($classname(), "Data")
	
	#dim stream As %Stream.TmpCharacter 
	set stream = xdata.Data
	
	set reader = ##class(%XML.Reader).%New()
	set sc=reader.OpenStream(stream)
	quit:$$$ISERR(sc) sc
	do reader.Correlate("Passenger", $classname())
	
	do ..%KillExtent()
	while reader.Next(.obj, .sc) {
		set sc = obj.%Save()
		quit:$$$ISERR(sc)
	}
	
	quit sc
}



}

