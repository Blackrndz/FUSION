/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description: TEST JENKIN ERROR
 * ************************************************************************** */
 

SELECT MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_NAME RES_NAME
,MtlTxnSourceTypes.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'INV_USER_DEFINED'
	AND LOOKUP_CODE = MtlTxnSourceTypes.USER_DEFINED_FLAG
	) RES_DEFINED_BY
,'' RES_VALUE_SET -- Cannot find Data for this column.
,TO_CHAR(MtlTxnSourceTypes.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(MtlTxnSourceTypes.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,MtlTxnSourceTypes.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,MtlTxnSourceTypes.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,MtlTxnSourceTypes.CREATED_BY RSC_CREATED_BY
,MtlTxnSourceTypes.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_TXN_SOURCE_TYPES_VL MtlTxnSourceTypes
WHERE((transaction_source_type_id NOT                      IN(8,18)
AND(FUSION.inv_logistics_release_level.get_logistics_release_level < 10))
OR(FUSION.inv_logistics_release_level.get_logistics_release_level >= 10))
ORDER BY MtlTxnSourceTypes.TRANSACTION_SOURCE_TYPE_NAME