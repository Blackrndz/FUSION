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
,'Asset book' RES_SECURITY_CONTEXT
,(SELECT BOOK_TYPE_CODE
	FROM FA_BOOK_CONTROLS
	WHERE BOOK_CONTROL_ID = UserRoleE0.BOOK_ID
	) RES_SECURITY_CONTEXT_VALUE
,UserRoleE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,UserRoleE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,UserRoleE0.CREATED_BY RSC_CREATED_BY
,UserRoleE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM FUN_USER_ROLE_DATA_ASGNMNTS UserRoleE0
,PER_USERS UserE0
,PER_ROLES_DN_VL RoleE0
WHERE UserRoleE0.USER_GUID = UserE0.USER_GUID
AND UserRoleE0.ROLE_NAME = RoleE0.ROLE_COMMON_NAME
AND UserRoleE0.ACTIVE_FLAG = 'Y'
AND UserRoleE0.BOOK_ID IS NOT NULL
ORDER BY UserE0.USERNAME
,RoleE0.ROLE_NAME