/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Spreadsheet%20Business%20Object%20Access%20-%20Job%20and%20Abstract%20Roles.sql $:
 * $Id: Manage Spreadsheet Business Object Access - Job and Abstract Roles.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT perROLEO.ROLE_NAME RES_ROLE
,perROLEO.ROLE_COMMON_NAME RES_CODE
,perROLEO.DESCRIPTION RES_DESCRIPTION
,perROLEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,perROLEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,perROLEO.CREATED_BY RSC_CREATED_BY
,perROLEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PER_ROLES_DN_VL perROLEO