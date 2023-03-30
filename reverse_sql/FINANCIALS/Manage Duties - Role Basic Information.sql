 /* ****************************************************************************
 * $Revision: 48884 $:
 * $Author: dhara.pithadiya $:
 * $Date: 2015-08-18 14:24:02 +0700 (Tue, 18 Aug 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Types%20-%20Manage%20Transaction%20Types.sql $:
 * $Id: Manage Transaction Types - Manage Transaction Types.sql 48884 2015-08-18 07:24:02Z dhara.pithadiya $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=ASE_APP_ROLE_VL

WITH ROLE_CAT AS(SELECT ActionsE0.ACTION_ID
	,ActionsE0.ATTRIBUTE_VALUE_TEXT ROLE_CODE
	,ROLE_CAT.ATTR_VALUE ROLE_CAT_NAME
	--,ROLE_CAT_CODE.ATTR_VALUE ROLE_CAT_CODE
	FROM ASE_STAGED_ACTION_VALUE ActionsE0
	,(SELECT ActionsE1.ATTRIBUTE_VALUE_TEXT ATTR_VALUE
		,ActionsE1.ACTION_ID
		FROM ASE_STAGED_ACTION_VALUE ActionsE1
		WHERE ActionsE1.ATTRIBUTE_NAME = 'ROLE_CATEGORY_NAME'
		AND ActionsE1.ATTRIBUTE_TYPE = 'java.lang.String'
		) ROLE_CAT
	/*,(SELECT ActionsE1.ATTRIBUTE_VALUE_TEXT ATTR_VALUE
		,ActionsE1.ACTION_ID
		FROM ASE_STAGED_ACTION_VALUE ActionsE1
		WHERE ActionsE1.ATTRIBUTE_NAME = 'ROLE_CATEGORY'
		AND ActionsE1.ATTRIBUTE_TYPE = 'java.lang.String'
		) ROLE_CAT_CODE*/
	WHERE ActionsE0.ACTION_ID IN (SELECT ACTION_ID FROM ASE_STAGED_ACTION WHERE ACTION_TYPE = 'APPLICATION_ROLE' AND ACTION_NAME NOT LIKE 'D%')
	AND ActionsE0.ATTRIBUTE_NAME = 'ROLE_CODE'
	AND ActionsE0.ATTRIBUTE_TYPE = 'java.lang.String'
	AND ActionsE0.ACTION_ID = ROLE_CAT.ACTION_ID
	--AND ActionsE0.ACTION_ID = ROLE_CAT_CODE.ACTION_ID
	)

SELECT DutyRolesE0.ROLE_NAME RES_ROLE_NAME
,DutyRolesE0.CODE RES_ROLE_CODE
,NVL(ROLE_CAT.ROLE_CAT_NAME,ROLE_CAT2.ROLE_TYPE_NAME) RES_ROLE_CATEGORY
/*,(SELECT ROLE_TYPE_NAME
	FROM ASE_ROLE_TYPE_VL
	WHERE ROLE_TYPE_CODE = DutyRolesE0.ROLE_TYPE_CODE
	AND LANGUAGE = USERENV('LANG')
	) RES_ROLE_CATEGORY*/
,DECODE(DutyRolesE0.IS_SEEDED,'Y','Yes','No') RES_PREDEFINED_ROLE
,DutyRolesE0.DESCRIPTION RES_DESCRIPTION
-- Add decode the Created and Updated users due to this task alway update based on the sync for all record at once
,DECODE(DutyRolesE0.IS_SEEDED,'Y','SEED_DATA_FROM_APPLICATION',DutyRolesE0.LAST_UPDATED_BY)  RSC_LAST_UPDATED_BY
,DutyRolesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
-- Add decode the Created and Updated users due to this task alway update based on the sync for all record at once
,DECODE(DutyRolesE0.IS_SEEDED,'Y','SEED_DATA_FROM_APPLICATION',DutyRolesE0.CREATED_BY)  RSC_CREATED_BY
,DutyRolesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM ASE_ROLE_VL DutyRolesE0
,(SELECT DISTINCT ROLE_CAT_NAME
	,ROLE_CODE
	FROM ROLE_CAT
	) ROLE_CAT
,(SELECT ROLE_TYPE_CODE
	,ROLE_TYPE_NAME
	FROM ASE_ROLE_TYPE_VL
	WHERE LANGUAGE = USERENV('LANG')
	) ROLE_CAT2
WHERE SYSDATE BETWEEN DutyRolesE0.EFFECTIVE_START_DATE AND NVL(DutyRolesE0.EFFECTIVE_END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND DutyRolesE0.CODE = ROLE_CAT.ROLE_CODE(+)
AND DutyRolesE0.ROLE_TYPE_CODE = ROLE_CAT2.ROLE_TYPE_CODE(+)
ORDER BY DutyRolesE0.ROLE_NAME