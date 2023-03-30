 /* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Receivables%20Customer%20Profile%20Classes%20-%20Receivables%20Customer%20Profile%20Class.sql $:
 * $Id: Manage Receivables Customer Profile Classes - Receivables Customer Profile Class.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
SELECT HzCustProfileClasses.NAME AS RES_PROFILE_CLASS_NAME
,HzCustProfileClasses.DESCRIPTION AS RES_DESCRIPTION
,(SELECT MEANING
	FROM ar_lookups
	WHERE LOOKUP_TYPE = 'CODE_STATUS'
	AND LOOKUP_CODE   = HzCustProfileClasses.STATUS
	) AS RES_STATUS
,HzCustProfileClasses.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,HzCustProfileClasses.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,HzCustProfileClasses.CREATED_BY  RSC_CREATED_BY
,HzCustProfileClasses.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM HZ_CUST_PROFILE_CLASSES HzCustProfileClasses
ORDER BY HzCustProfileClasses.NAME
 
 