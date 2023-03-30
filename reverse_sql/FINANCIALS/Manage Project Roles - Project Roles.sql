/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Project%20Roles%20-%20Project%20Roles.sql $:
 * $Id: Manage Project Roles - Project Roles.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
 
SELECT pjfPROCTypesE0.PROJECT_ROLE_NAME  RES_NAME
,pjfPROCTypesE0.DESCRIPTION RES_DESCRIPTION
,perROLESDNE0.ROLE_NAME RES_ENTERPRISE_ROLE
,TO_CHAR(pjfPROCTypesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(pjfPROCTypesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,pjfPROCTypesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfPROCTypesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfPROCTypesE0.CREATED_BY  RSC_CREATED_BY
,pjfPROCTypesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
 
FROM PJF_PROJ_ROLE_TYPES_VL pjfPROCTypesE0
,PER_ROLES_DN_VL perROLESDNE0
WHERE pjfPROCTypesE0.ROLE_ID = perROLESDNE0.ROLE_ID (+)
AND pjfPROCTypesE0.PROJECT_ROLE_ID  NOT IN (100,101,102)

