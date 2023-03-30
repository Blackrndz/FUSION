/* ****************************************************************************
* $Revision: 80357 $:
* $Author: tanawat.wongjan $:
* $Date: 2023-03-01 15:10:38 +0700 (Wed, 01 Mar 2023) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Work%20Types%20-%20Work%20Types.sql $:
* $Id: Manage Work Types - Work Types.sql 80357 2023-03-01 08:10:38Z tanawat.wongjan $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT 	pjfWorkTypeEO.NAME								RES_WORK_TYPE
,pjfWorkTypeEO.DESCRIPTION								RES_DESCRIPTION
,DECODE(pjfWorkTypeEO.BILLABLE_CAPITALIZABLE_FLAG,'Y','Yes','No') RES_BILLABLE
,(SELECT MEANING FROM FND_LOOKUPS
	WHERE  LOOKUP_TYPE = 'PJF_TP_AMT_TYPE_CODE'
		AND LOOKUP_CODE = pjfWorkTypeEO.TP_AMT_TYPE_CODE) RES_TRANSFER_PRICE_AMOUNT_TYPE
,TO_CHAR(pjfWorkTypeEO.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(pjfWorkTypeEO.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,DECODE(pjfWorkTypeEO.UTILIZABLE_FLAG,'Y','Yes','No') RES_UTILIZABLE
,pjfWorkTypeEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,pjfWorkTypeEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,pjfWorkTypeEO.CREATED_BY  RSC_CREATED_BY
,pjfWorkTypeEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_WORK_TYPES_VL pjfWorkTypeEO
ORDER BY pjfWorkTypeEO.NAME