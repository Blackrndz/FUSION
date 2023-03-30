/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT ApprovedSupplierListStatusEO.STATUS RES_STATUS
,ApprovedSupplierListStatusEO.STATUS_DESCRIPTION RES_DESCRIPTION
,DECODE(ApprovedSupplierListStatusEO.ASL_DEFAULT_FLAG,'Y','Yes','No') RES_DEFAULT_STATUS
,DECODE(ApprovedSupplierListStatusEO.ALLOW_PO_APPROVAL_FLAG,'Y','Yes','No') RES_ALLOW_PURCHASE_ORDER_APPRO
,DECODE(ApprovedSupplierListStatusEO.ALLOW_SOURCING_FLAG,'Y','Yes','No') RES_ALLOW_DOCUMENT_SOURCING
,TO_CHAR(ApprovedSupplierListStatusEO.INACTIVE_DATE,'DD-Mon-YYYY') RES_END_DATE
,ApprovedSupplierListStatusEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,ApprovedSupplierListStatusEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,ApprovedSupplierListStatusEO.CREATED_BY RSC_CREATED_BY
,ApprovedSupplierListStatusEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PO_ASL_STATUSES ApprovedSupplierListStatusEO
ORDER BY ApprovedSupplierListStatusEO.ASL_DEFAULT_FLAG DESC
,ApprovedSupplierListStatusEO.STATUS ASC