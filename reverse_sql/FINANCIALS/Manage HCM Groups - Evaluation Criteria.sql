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
,ROW_NUMBER() OVER (PARTITION BY hcmGroupsE0.GRP_ID ORDER BY criteriaE0.ORDR_NUM) RES_SEQUENCE
,criteriaE0.CRITERIA_NAME RES_EVALUATION_CRITERIA
,criteriaE0.OPERATOR_NAME RES_OPERATOR
,NVL(criteriaE0.CRITERIA_DISPLAY_NAME ,
	NVL(criteriaE0.VALUE_CHAR,
		NVL(criteriaE0.VALUE_NUMBER,
			NVL(TO_CHAR(criteriaE0.VALUE_DATE,'DD-Mon-YYYY'),TO_CHAR(criteriaE0.VALUE_TS,'DD-Mon-YYYY HH24:MI:SS')
				)
			)
		)
	) RES_VALUE
,(CASE
	WHEN criteriaE0.CRITERIA_NAME = 'Location Components' THEN
		criteriaE0.ADDL_ATTR_CHAR2
	END) RES_STATE
,(CASE
	WHEN criteriaE0.CRITERIA_NAME = 'Location Components' THEN
		criteriaE0.ADDL_ATTR_CHAR3
	END) RES_COUNTY
,(CASE
	WHEN criteriaE0.CRITERIA_NAME = 'Location Components' THEN
		criteriaE0.ADDL_ATTR_CHAR4
	END) RES_CITY
,DECODE(criteriaE0.BOOL_OPER_CD,'OR','Or','AND','And') RES_LOGICAL_OPERATOR
,criteriaE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,criteriaE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,criteriaE0.CREATED_BY  RSC_CREATED_BY
,criteriaE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HWM_GRPS_VL hcmGroupsE0
,HWM_GRP_CRITERIA criteriaE0
WHERE hcmGroupsE0.ONLINE_EVAL_FLAG = 'N'
AND hcmGroupsE0.GRP_ID = criteriaE0.GRP_ID
ORDER BY hcmGroupsE0.GROUP_NAME
,criteriaE0.ORDR_NUM