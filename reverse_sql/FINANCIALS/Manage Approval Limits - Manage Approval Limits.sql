/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Approval%20Limits%20-%20Manage%20Approval%20Limits.sql $:
 * $Id: Manage Approval Limits - Manage Approval Limits.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT UserPEO.USERNAME RES_USER_NAME
,DECODE(AR.DOCUMENT_TYPE,'ADJ','Adjustment','CMREF','Credit Memo Refund','WRTOFF','Receipt write off')
	RES_DOCUMENT_TYPE
,(SELECT curr.CURRENCY_CODE || ' - ' || curr.NAME
	FROM fusion.fnd_currencies_vl curr
	WHERE curr.CURRENCY_CODE = AR.CURRENCY_CODE
	) RES_CURRENCY
,AR.AMOUNT_FROM RES_MINIMUM_APPROVAL_AMOUNT
,AR.AMOUNT_TO RES_MAXIMUM_APPROVAL_AMOUNT
,PER.DISPLAY_NAME RES_USER_DISPLAY_NAME
,AR.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,AR.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,AR.CREATED_BY RSC_CREATED_BY
,AR.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM fusion.AR_APPROVAL_USER_LIMITS AR
,fusion.PER_USERS UserPEO
,fusion.PER_PERSON_NAMES_F_V PER
WHERE AR.user_id          = UserPEO.user_guid(+)
AND AR.document_type NOT IN('CM')
AND UserPEO.person_id     = PER.person_id(+)
ORDER BY UserPEO.USERNAME
,RES_DOCUMENT_TYPE
,AR.CURRENCY_CODE
,AR.AMOUNT_FROM