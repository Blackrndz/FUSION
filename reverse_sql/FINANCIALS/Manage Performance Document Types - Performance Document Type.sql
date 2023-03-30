/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Performance%20Document%20Types%20-%20Performance%20Document%20Type.sql $:
 * $Id: Manage Performance Document Types - Performance Document Type.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT  hRADTEO.NAME RES_NAME
,hRADTEO.DESCRIPTION RES_DESCRIPTION
,TO_CHAR(hRADTEO.DATE_FROM,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(hRADTEO.DATE_TO,'DD-Mon-YYYY') RES_TO_DATE
,DECODE(hRADTEO.STATUS_CODE,'A','Active','I','Inactive') RES_STATUS
,DECODE(hRADTEO.SELECT_MGR_ALLOWED_FLAG,'Y','Yes','No') RES_WORKER_CAN_SELECT_MANAGER_
,hRADTEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,hRADTEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,hRADTEO.CREATED_BY RSC_CREATED_BY
,hRADTEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HRA_DOC_TYPES_VL  hRADTEO
ORDER BY hRADTEO.NAME
