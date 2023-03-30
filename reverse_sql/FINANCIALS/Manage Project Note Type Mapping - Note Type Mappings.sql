/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT sourceObjectsE0.OBJECT_NAME RES_BUSINESS_OBJECT
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'ZMM_NOTE_TYPE'
	AND LOOKUP_CODE = mappingE0.MAPPED_LOOKUP_CODE
	) RES_MAPPED_LOOKUP_VALUE
,TO_CHAR(mappingE0.MAPPING_END_DATE,'DD-Mon-YYYY') RES_END_DATE
,mappingE0.DEFAULT_FLAG RES_DEFAULT
,mappingE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,mappingE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,mappingE0.CREATED_BY  RSC_CREATED_BY
,mappingE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ZMM_OBJECT_LOOKUP_MAPPINGS mappingE0
,ZMM_OBJECT_USAGES objUsagesE0
,ZMM_OBJECTS_VL sourceObjectsE0
WHERE mappingE0.SOURCE_OBJECT_CODE = objUsagesE0.OBJECT_CODE
AND objUsagesE0.WEB_APPLICATION_CODE = 'ProjectsFinancials'
AND mappingE0.SOURCE_OBJECT_CODE = sourceObjectsE0.OBJECT_CODE
ORDER BY sourceObjectsE0.OBJECT_NAME,2