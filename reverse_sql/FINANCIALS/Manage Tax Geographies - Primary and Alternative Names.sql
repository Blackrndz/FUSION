/* $Revision: 59117 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-21 11:10:58 +0700 (Fri, 21 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Key%20Flexfields%20-%20Segment%20Labels.sql $:
* $Id: Manage Key Flexfields - Segment Labels.sql 59117 2016-10-21 04:10:58Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT countriesE0.GEOGRAPHY_NAME RES_COUNTRY_NAME
,DECODE(identifiersE0.PRIMARY_FLAG,'Y','Yes','No') RES_PRIMARY
,identifiersE0.IDENTIFIER_VALUE RES_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'HZ_GEO_DATA_PROVIDER'
	AND LOOKUP_CODE = identifiersE0.GEO_DATA_PROVIDER
	) RES_DATA_PROVIDER
,(SELECT DESCRIPTION
	FROM FND_LANGUAGES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND LANGUAGE_CODE = identifiersE0.LANGUAGE_CODE
	) RES_LANGUAGE
,identifiersE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,identifiersE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,identifiersE0.CREATED_BY RSC_CREATED_BY
,identifiersE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_GEOGRAPHIES countriesE0
,HZ_GEOGRAPHY_IDENTIFIERS identifiersE0
WHERE countriesE0.GEOGRAPHY_TYPE = 'COUNTRY'
AND countriesE0.GEOGRAPHY_ID = identifiersE0.GEOGRAPHY_ID
AND identifiersE0.IDENTIFIER_TYPE = 'NAME'
ORDER BY countriesE0.GEOGRAPHY_NAME
,DECODE(identifiersE0.PRIMARY_FLAG,'Y',1,2)