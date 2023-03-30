/* ****************************************************************************
 * $Revision: 60928 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-02-06 17:14:01 +0700 (Mon, 06 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Complete%20Primary%20to%20Secondary%20Ledger%20Mapping%20-%20Journal%20Conversion%20Rules.sql $:
 * $Id: Complete Primary to Secondary Ledger Mapping - Journal Conversion Rules.sql 60928 2017-02-06 10:14:01Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_GRPS_VL
 
SELECT hcmGroupsE0.GROUP_NAME RES_NAME
,hcmInclGrpsE0.ORDER_NUM RES_PRIORITY
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'ORA_HWM_GROUP_INCLUDE_EXCLUDE'
	AND LOOKUP_CODE = hcmInclGrpsE0.GRP_OR_VALUESET_CD
	) RES_TYPE
,(CASE
	WHEN hcmInclGrpsE0.GRP_OR_VALUESET_CD = 'ORA_HWM_VALUESET' THEN
		(SELECT VALUE_SET_CODE FROM FND_VS_VALUE_SETS WHERE VALUE_SET_ID = hcmInclGrpsE0.INCL_GRP_ID)
	WHEN hcmInclGrpsE0.GRP_OR_VALUESET_CD = 'ORA_HWM_GROUP' THEN
		(SELECT GROUP_NAME FROM HWM_GRPS_VL WHERE GRP_ID = hcmInclGrpsE0.INCL_GRP_ID)
	END) RES_GROUPS_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'HWM_GRP_INCL_EXCL'
	AND LOOKUP_CODE = hcmInclGrpsE0.INCL_FLAG
	) RES_CONDITION
,hcmInclGrpsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,hcmInclGrpsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,hcmInclGrpsE0.CREATED_BY  RSC_CREATED_BY
,hcmInclGrpsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_GRPS_VL hcmGroupsE0
,HWM_GRP_INCL_GRPS hcmInclGrpsE0
WHERE hcmGroupsE0.ONLINE_EVAL_FLAG = 'N'
AND hcmGroupsE0.GRP_ID = hcmInclGrpsE0.GRP_ID
ORDER BY hcmGroupsE0.GROUP_NAME
,hcmInclGrpsE0.ORDER_NUM