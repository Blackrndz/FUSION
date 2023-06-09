/* ****************************************************************************
 * $Revision: 53604 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-17 10:27:55 +0700 (Thu, 17 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/branches/core/v2.2.0.0/reverse_sql/FINANCIALS/Assign%20Balancing%20Segment%20Values%20to%20Ledger%20(Primary%20Ledger)%20-%20Assign%20Balancing%20Segment%20Value $:
 * $Id: Assign Balancing Segment Values to Ledger (Primary Ledger) - Assign Balancing Segment Values to Ledger.sql 53604 2016-03-17 03:27:55Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=FUN_USER_ROLE_DATA_ASGNMNTS

SELECT UserE0.USERNAME RES_USER_NAME
,RoleE0.ROLE_NAME RES_ROLE
,(CASE
	WHEN UserRoleE0.ORG_ID IS NOT NULL THEN
		'Business unit'
	WHEN UserRoleE0.LEDGER_ID IS NOT NULL THEN
		'Ledger'
	WHEN UserRoleE0.BOOK_ID IS NOT NULL THEN
		'Asset book'
	WHEN UserRoleE0.SET_ID IS NOT NULL THEN
		'Reference data set'
	WHEN UserRoleE0.INV_ORGANIZATION_ID IS NOT NULL THEN
		'Inventory organization'
	WHEN UserRoleE0.CST_ORGANIZATION_ID IS NOT NULL THEN
		'Cost organization'
	WHEN UserRoleE0.ACCESS_SET_ID IS NOT NULL THEN
		'Data access set'
	WHEN UserRoleE0.CONTROL_BUDGET_ID IS NOT NULL THEN
		'Control budget'
	WHEN UserRoleE0.INTERCO_ORG_ID IS NOT NULL THEN
		'Intercompany organization'
	WHEN UserRoleE0.PRJ_ORGANIZATION_ID IS NOT NULL THEN
		'Project organization classification'
	WHEN UserRoleE0.MFG_ORGANIZATION_ID IS NOT NULL THEN
		'Manufacturing plant'
	END) RES_SECURITY_CONTEXT
,(CASE
	WHEN UserRoleE0.ORG_ID IS NOT NULL THEN
		(SELECT BU_NAME 
			FROM FUN_ALL_BUSINESS_UNITS_V 
			WHERE BU_ID = UserRoleE0.ORG_ID
			AND SYSDATE BETWEEN DATE_FROM AND DATE_TO)
	WHEN UserRoleE0.LEDGER_ID IS NOT NULL THEN
		(SELECT NAME
			FROM GL_LEDGERS
			WHERE LEDGER_ID = UserRoleE0.LEDGER_ID)
	WHEN UserRoleE0.BOOK_ID IS NOT NULL THEN
		(SELECT BOOK_TYPE_CODE
			FROM FA_BOOK_CONTROLS
			WHERE BOOK_CONTROL_ID = UserRoleE0.BOOK_ID)
	WHEN UserRoleE0.SET_ID IS NOT NULL THEN
		(SELECT SET_NAME
			FROM FND_SETID_SETS_VL
			WHERE SET_ID = UserRoleE0.SET_ID)
	WHEN UserRoleE0.INV_ORGANIZATION_ID IS NOT NULL THEN
		(SELECT ORGANIZATION_CODE 
			FROM INV_ORG_PARAMETERS
			WHERE ORGANIZATION_ID = UserRoleE0.INV_ORGANIZATION_ID)
	WHEN UserRoleE0.CST_ORGANIZATION_ID IS NOT NULL THEN
		(SELECT COST_ORG_NAME
			FROM CST_COST_ORGS_V
			WHERE COST_ORG_ID = UserRoleE0.CST_ORGANIZATION_ID
			AND SYSDATE BETWEEN EFFECTIVE_START_DATE AND EFFECTIVE_END_DATE)
	WHEN UserRoleE0.ACCESS_SET_ID IS NOT NULL THEN
		(SELECT NAME
			FROM GL_ACCESS_SETS
			WHERE ACCESS_SET_ID = UserRoleE0.ACCESS_SET_ID)
	WHEN UserRoleE0.CONTROL_BUDGET_ID IS NOT NULL THEN
		(SELECT NAME
			FROM XCC_CONTROL_BUDGETS
			WHERE CONTROL_BUDGET_ID = UserRoleE0.CONTROL_BUDGET_ID)
	WHEN UserRoleE0.INTERCO_ORG_ID IS NOT NULL THEN
		(SELECT INTERCO_ORG_NAME
			FROM FUN_INTERCO_ORGANIZATIONS
			WHERE INTERCO_ORG_ID = UserRoleE0.INTERCO_ORG_ID)
	WHEN UserRoleE0.PRJ_ORGANIZATION_ID IS NOT NULL THEN
		NULL --HR_ORG_UNIT_CLASSIFICATIONS_F
	WHEN UserRoleE0.MFG_ORGANIZATION_ID IS NOT NULL THEN
		NULL --RCS_MFG_PARAMETERS
	END) RES_SECURITY_CONTEXT_VALUE
,UserRoleE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,UserRoleE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,UserRoleE0.CREATED_BY RSC_CREATED_BY
,UserRoleE0.CREATION_DATE RSC_CREATION_DATE
,UserRoleE0.LEDGER_ID RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,UserRoleE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,NVL(UserRoleE0.INV_ORGANIZATION_ID,NVL(UserRoleE0.CST_ORGANIZATION_ID,NVL(UserRoleE0.INTERCO_ORG_ID,NVL(UserRoleE0.PRJ_ORGANIZATION_ID,UserRoleE0.MFG_ORGANIZATION_ID)))) RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM FUN_USER_ROLE_DATA_ASGNMNTS UserRoleE0
,PER_USERS UserE0
,PER_ROLES_DN_VL RoleE0
WHERE UserRoleE0.USER_GUID = UserE0.USER_GUID
AND UserRoleE0.ROLE_NAME = RoleE0.ROLE_COMMON_NAME
AND UserRoleE0.ACTIVE_FLAG = 'Y'
ORDER BY UserE0.USERNAME
,RoleE0.ROLE_NAME