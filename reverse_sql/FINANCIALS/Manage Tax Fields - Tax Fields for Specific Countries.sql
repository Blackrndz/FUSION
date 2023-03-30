/* ****************************************************************************
 * $Revision: 50797 $:
 * $Author: wuttipong.thongvises $:
 * $Date: 2015-11-24 16:49:46 +0700 (Tue, 24 Nov 2015) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Revenue%20Policies%20-%20Manage%20Revenue%20Policies.sql $:
 * $Id: Manage Revenue Policies - Manage Revenue Policies.sql 50797 2015-11-24 09:49:46Z wuttipong.thongvises $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=EXM_VAT_FIELDS

select BusinessUnitPEO.BU_NAME   RES_BUSINESS_UNIT
, (SELECT distinct TerritoryPEO.territory_short_name 
   FROM FND_TERRITORIES_VL TerritoryPEO  
   WHERE TerritoryPEO.TERRITORY_CODE = VatFieldEO.territory_code )   RES_COUNTRY_OR_TERRITORY
,(select meaning 
	from fnd_lookups 
	where lookup_type = 'EXM_FIELD_BEHAVIOUR' 
	and lookup_code = ENABLE_MERCHANT_NAME_CODE  
	) RES_MERCHANT_NAME
,(select meaning 
	from fnd_lookups 
	where lookup_type = 'EXM_FIELD_BEHAVIOUR' 
	and lookup_code = ENABLE_MERCHANT_TAXPAYER_CODE   
	) RES_TAXPAYER_ID
,(select meaning 
	from fnd_lookups 
	where lookup_type = 'EXM_FIELD_BEHAVIOUR' 
	and lookup_code = ENABLE_MERCHANT_RECEIPT_CODE  
	) RES_RECEIPT_NUMBER
,(select meaning 
	from fnd_lookups 
	where lookup_type = 'EXM_FIELD_BEHAVIOUR' 
	and lookup_code = ENABLE_MERCHANT_REFERENCE_CODE   
	) RES_MERCHANT_REFERENCE
,(select meaning 
	from fnd_lookups 
	where lookup_type = 'EXM_FIELD_BEHAVIOUR' 
	and lookup_code = ENABLE_MERCHANT_TAX_REG_CODE    
	) RES_TAX_REGISTRATION_NUMBER
,(select meaning 
	from fnd_lookups 
	where lookup_type = 'EXM_FIELD_BEHAVIOUR' 
	and lookup_code = ENABLE_TAX_CLASSIFICATION_CODE
	) RES_TAX_CLASSIFICATION_CODE
,VatFieldEO.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,VatFieldEO.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,VatFieldEO.CREATED_BY  	RSC_CREATED_BY
,VatFieldEO.CREATION_DATE  	RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,VatFieldEO.org_id RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
from EXM_VAT_FIELDS VatFieldEO  
,FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
WHERE businessunitpeo.bu_id =VatFieldEO.org_id(+)
AND TERRITORY_CODE <> 'OTHER'
ORDER BY BusinessUnitPEO.BU_NAME,RES_COUNTRY_OR_TERRITORY