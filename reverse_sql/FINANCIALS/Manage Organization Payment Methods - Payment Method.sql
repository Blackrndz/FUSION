/* ****************************************************************************
 * $Revision: 75465 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2021-02-12 15:52:06 +0700 (Fri, 12 Feb 2021) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Organization%20Payment%20Methods%20-%20Organization%20Payment%20Method.sql $:
 * $Id: Manage Organization Payment Methods - Organization Payment Method.sql 75465 2021-02-12 08:52:06Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- RSC_PREREQUISITE_OBJECTS=PAY_ORG_PAY_METHODS_VL 
 
SELECT payORGPAYMETEO.ORG_PAYMENT_METHOD_NAME RES_NAME
,(SELECT NAME FROM PER_LEGISLATIVE_DATA_GROUPS_VL 
	WHERE LEGISLATIVE_DATA_GROUP_ID = payORGPAYMETEO.LEGISLATIVE_DATA_GROUP_ID) RES_LEGISLATIVE_DATA_GROUP

	
  ,payORGPAYMETEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,payORGPAYMETEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,payORGPAYMETEO.CREATED_BY  RSC_CREATED_BY
  ,payORGPAYMETEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM PAY_ORG_PAY_METHODS_VL payORGPAYMETEO
WHERE payORGPAYMETEO.PARENT_ORG_PAY_METHOD_ID IS NULL
--AND SYSDATE BETWEEN payORGPAYMETEO.EFFECTIVE_START_DATE AND NVL(payORGPAYMETEO.EFFECTIVE_END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY 1