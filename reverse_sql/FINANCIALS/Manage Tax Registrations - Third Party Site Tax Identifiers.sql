/* ****************************************************************************
 * $Revision: 50638 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-18 14:55:09 +0700 (Wed, 18 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cumulative%20Mileage%20Determinants%20-%20Manage%20Cumulative%20Mileage%20Determinants.sql $:
 * $Id: Manage Cumulative Mileage Determinants - Manage Cumulative Mileage Determinants.sql 50638 2015-11-18 07:55:09Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=ZX_PARTY_TAXPAYER_IDNTFS  
 
SELECT PartyPEO.PARTY_NAME RES_PARTY_NAME
,PartyPEO.PARTY_NUMBER RES_PARTY_NUMBER
,PartySitePEO.PARTY_SITE_NAME RES_PARTY_SITE_NAME
,PartySitePEO.PARTY_SITE_NUMBER RES_PARTY_SITE_NUMBER
,ZxReportingTypesVl.REPORTING_TYPE_NAME RES_VALIDATION_TYPE
,TaxPayerIdentifierEO.TAX_PAYER_NUMBER RES_TAXPAYER_ID
,TaxPayerIdentifierEO.VALIDATION_DIGIT RES_VALIDATION_DIGIT
,TO_CHAR(TaxPayerIdentifierEO.EFFECTIVE_FROM,'DD-Mon-YYYY') RES_EFFECTIVE_START_DATE
,TO_CHAR(TaxPayerIdentifierEO.EFFECTIVE_TO,'DD-Mon-YYYY') RES_EFFECTIVE_END_DATE
,TaxPayerIdentifierEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,TaxPayerIdentifierEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,TaxPayerIdentifierEO.CREATED_BY RSC_CREATED_BY
,TaxPayerIdentifierEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZX_PARTY_TAXPAYER_IDNTFS TaxPayerIdentifierEO
,ZX_PARTY_TAX_PROFILE ZxPartyTaxProfile
,HZ_PARTIES PartyPEO
,HZ_PARTY_SITES PartySitePEO
,ZX_REPORTING_TYPES_VL ZxReportingTypesVl
WHERE TaxPayerIdentifierEO.ENTITY_ID = ZxPartyTaxProfile.PARTY_TAX_PROFILE_ID
AND ZxPartyTaxProfile.PARTY_TYPE_CODE = 'THIRD_PARTY_SITE'
AND ZxPartyTaxProfile.PARTY_ID = PartySitePEO.PARTY_SITE_ID
AND PartySitePEO.PARTY_ID = PartyPEO.PARTY_ID
AND ZxReportingTypesVl.REPORTING_TYPE_CODE = TaxPayerIdentifierEO.REPORTING_TYPE_CODE
ORDER BY RES_PARTY_NAME