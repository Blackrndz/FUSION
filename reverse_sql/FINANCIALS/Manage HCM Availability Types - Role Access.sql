/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=ANC_AVAILABILITY_TYPES_VL

SELECT avalTypesE0.NAME RES_NAME
,(SELECT ROLE_NAME
	FROM PER_ROLES_DN_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND ROLE_ID = rolesE0.ROLE_ID 
	) RES_ROLE_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'ORA_ANC_ROLE_ACCESS_LEVELS'
	AND LOOKUP_CODE = rolesE0.ROLE_ACCESS_LEVEL 
	) RES_ACCESS_LEVEL
,rolesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,rolesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,rolesE0.CREATED_BY  RSC_CREATED_BY
,rolesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,avalTypesE0.LEGISLATION_CODE  RSC_COUNTRY_ID
 
FROM ANC_AVAILABILITY_TYPES_VL avalTypesE0
,ANC_AVAILABILITY_TYPE_PRIVS rolesE0
WHERE avalTypesE0.AVAILABILITY_TYPE_ID = rolesE0.AVAILABILITY_TYPE_ID
ORDER BY avalTypesE0.NAME