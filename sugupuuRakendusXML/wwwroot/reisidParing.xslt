<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="UTF-8"/>

	<xsl:template match="/">

	<storng>Kõik suunad</storng>

		<table border="1">
			<tr>
				<th>Sihtkoht</th>
				<th>Kliendi hinne</th>
				<th>Transport</th>
				<th>Hotell</th>
				<th>Ööd</th>
				<th>Ekskursioon</th>
				<th>Toitlustus</th>
				<th>Kindlustus</th>
				<th>Muud kulud</th>
			</tr>

			<xsl:for-each select="//reis">
				<xsl:sort order="descending" data-type="number" select="@kliendiHinne"/>

				<tr>

					<td>
						<xsl:value-of select="sihtkoht"/>
					</td>
					<td>
						<xsl:value-of select="@kliendiHinne"/>
					</td>
					<td>
						<xsl:for-each select="komponent[@tyyp='transport']/*">
							<xsl:value-of select="name()"/>
							<xsl:if test="position() != last()">, </xsl:if>
						</xsl:for-each>
					</td>
					<td>
						<xsl:value-of select="komponent[@tyyp='majutus']/hotell/nimi"/>
					</td>
					<td>
						<xsl:value-of select="komponent[@tyyp='majutus']/hotell/ood"/>
					</td>
					<td>
						<xsl:value-of select="komponent[@tyyp='ekskursioon']/tuur/nimi"/>
					</td>
					<td>
						<xsl:value-of select="komponent[@tyyp='toitlustus']/restoran/nimi"/>
					</td>
					<td>
						<xsl:value-of select="komponent[@tyyp='kindlustus']/kindlustusplaan/ettevote"/>
					</td>
					<td>
						<xsl:value-of select="komponent[@tyyp='muudKulud']/kulud/@hind"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>
		
	<xsl:for-each select="reisid/reis">
		

        <h1>
            <xsl:value-of select="sihtkoht"/>
        </h1>

        <ul>
			<xsl:for-each select="komponent">
				<li style="background-color: yellow;">
					<strong>
						<xsl:value-of select="@tyyp"/>
					</strong>
				</li>
			</xsl:for-each>
        </ul>

</xsl:for-each>
		<xsl:for-each select="//reis">
			<xsl:value-of select="sihtkoht"/>
			-
			<xsl:value-of select="komponent[@tyyp='majutus']/hotell/ood"/>
			ööd

			<xsl:if test="komponent[@tyyp='majutus'] /hotell/ood > 7">
				- Pikk reis</xsl:if>

			<br/>
		</xsl:for-each>

		<br></br>
		<xsl:for-each select="//reis">
			<xsl:value-of select="sihtkoht"/>
			-
			<xsl:value-of select="sum(komponent/*/@hind)"/>
			EUR
			<br/>
		</xsl:for-each>
		<br></br>
		<strong>Ainult need reisid, mille transpordiks on lennureis</strong>
		<br></br>
		<xsl:for-each select="//reis">
			<xsl:if test="komponent[@tyyp='transport']/lend">
				<xsl:value-of select="concat(sihtkoht, ' - lend: ', komponent[@tyyp='transport']/lend/lennufirma, ' ', komponent[@tyyp='transport']/lend/lennuNumber)"/>
				<br/><br/>
			</xsl:if>
		</xsl:for-each>
		<br></br>
		<strong>Reisid peavad olema kuvatud kestvuse alusel järjestatuna. Suurema kestvusega reis peab olema enne väikese kestvusega reisi.</strong>
		<xsl:for-each select="//reis">
			<xsl:sort select="komponent[@tyyp='majutus']/hotell/ood" data-type="number" order="descending"/>
			
			<xsl:value-of select="sihtkoht"/>
			-
			<xsl:value-of select="komponent[@tyyp='majutus']/hotell/ood"/>
			ööd	
			<br/>
		</xsl:for-each>

		<br></br>
		
	</xsl:template>

</xsl:stylesheet>
