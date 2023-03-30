/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT partiesE0.PARTY_NAME RES_NAME
,partiesE0.PARTY_NUMBER RES_NUMBER
,refE0.REFERENCE_NAME RES_TYPE
,sponsorrefE0.VALUE RES_VALUE
,refE0.DESCRIPTION RES_DESCRIPTION
,sponsorrefE0.COMMENTS RES_COMMENTS
,sponsorrefE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,sponsorrefE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,sponsorrefE0.CREATED_BY RSC_CREATED_BY
,sponsorrefE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM GMS_SPONSORS_VL sponsorsE0
,HZ_PARTIES partiesE0
,GMS_SPONSORS_REFERENCES_VL sponsorrefE0
,GMS_REFERENCES_VL refE0
WHERE sponsorsE0.PARTY_ID = partiesE0.PARTY_ID
AND sponsorsE0.SPONSOR_ID = sponsorrefE0.SPONSOR_ID
AND sponsorrefE0.REFERENCE_ID = refE0.REFERENCE_ID
ORDER BY partiesE0.PARTY_NAME
,refE0.REFERENCE_NAME