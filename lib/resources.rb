require 'yajl/json_gem'

module Cerner
  module Resources
    module Helpers

      STATUSES ||= {
        200 => '200 OK',
        201 => '201 Created',
        202 => '202 Accepted',
        204 => '204 No Content',
        205 => '205 Reset Content',
        301 => '301 Moved Permanently',
        302 => '302 Found',
        307 => '307 Temporary Redirect',
        304 => '304 Not Modified',
        401 => '401 Unauthorized',
        403 => '403 Forbidden',
        404 => '404 Not Found',
        405 => '405 Method not allowed',
        409 => '409 Conflict',
        422 => '422 Unprocessable Entity',
        500 => '500 Server Error',
        502 => '502 Bad Gateway'
      }


      def headers(status, head = {})
        lines = ["Status: #{STATUSES[status]}"]
        head.each do |key, value|
          case key
            when :pagination
              lines << link_header(value)
            else
              lines << "#{key}: #{value}"
          end
        end

        %(<pre class="headers"><code>#{lines * "\n"}</code></pre>\n)
      end

      def link_header(rels)
        formatted_rels = rels.map { |name, url| link_header_rel(name, url) }

        lines = ["Link: #{formatted_rels.shift}"]
        while formatted_rels.any?
          lines.last << ","
          lines << "      #{formatted_rels.shift}"
        end

        lines
      end

      def link_header_rel(name, url)
        %Q{<#{url}>; rel="#{name}"}
      end

      def json(key)
        hash = get_resource(key)
        hash = yield hash if block_given?

        %(<pre class="body-response"><code class="language-javascript">) +
          JSON.pretty_generate(hash) + "</code></pre>"
      end

      def get_resource(key)
        hash = case key
          when Hash
            h = {}
            key.each { |k, v| h[k.to_s] = v }
            h
          when Array
            key
          else Resources.const_get(key.to_s.upcase)
        end
      end

    end

    # DSTU 1 JSON

    DSTU1_ALLERGY_INTOLERANCE_BUNDLE ||= {
      "resourceType"=>"Bundle",
      "title"=>"Search results for resource type AllergyIntolerance",
      "id"=>"c295606f-2ed2-4fc8-8d21-6c9676fdde92",
      "link"=>[{"rel"=>"self",
                "href"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/AllergyIntolerance?subject:Patient=3602355"}],
      "updated"=>"2015-04-02T17:05:14.054+00:00",
      "author"=>[{"name"=>"Cerner Corporation"}],
      "entry"=>[{"title"=>"AllergyIntolerance Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/AllergyIntolerance/3276869",
                 "content"=>{"resourceType"=>"AllergyIntolerance",
                             "sensitivityType"=>"intolerance",
                             "recordedDate"=>"2015-03-26T17:06:21.000Z",
                             "status"=>"confirmed",
                             "subject"=>{"reference"=>"Patient/3602355"},
                             "substance"=>{"display"=>"Dust"}}},
                {"title"=>"AllergyIntolerance Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/AllergyIntolerance/3276865",
                 "content"=>{"resourceType"=>"AllergyIntolerance",
                             "sensitivityType"=>"intolerance",
                             "recordedDate"=>"2015-03-26T17:05:24.000Z",
                             "status"=>"confirmed",
                             "subject"=>{"reference"=>"Patient/3602355"},
                             "substance"=>{"display"=>"Peanuts"}}}]
    }

    DSTU1_CONDITION_BUNDLE ||= {
      "resourceType"=>"Bundle",
      "title"=>"Search results for resource type Condition",
      "id"=>"d2dd09d5-9de4-4fa6-937c-cf1d928011df",
      "link"=>[{"rel"=>"self",
                "href"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Condition?subject:Patient=3602355"}],
      "updated"=>"2015-04-02T17:20:27.848+00:00",
      "author"=>[{"name"=>"Cerner Corporation"}],
      "entry"=>[{"title"=>"Condition Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Condition/%2Ftenant%3Ad075cf8b-3261-481d-97e5-ba6c48d3b41f_0%2Fperson%3A3602355%2Fclinicalfacts.condition.type%3ACODIFIED%2Fid%3A17697298",
                 "content"=>{"resourceType"=>"Condition",
                             "contained"=>[{"resourceType"=>"Practitioner",
                                            "id"=>"practitioner1293205",
                                            "name"=>{"text"=>"Norton RN, Rona"},
                                            "organization"=>{"display"=>"Cerner Medical Center"}}],
                             "subject"=>{"reference"=>"Patient/3602355"},
                             "asserter"=>{"reference"=>"#practitioner1293205",
                                          "display"=>"Norton RN, Rona"},
                             "code"=>{"coding"=>[{"system"=>"http://hl7.org/fhir/sid/icd-9",
                                                  "code"=>"401.1",
                                                  "display"=>"Hypertension, benign essential, goal below 140/90"}],
                                      "text"=>"Hypertension, benign essential, goal below 140/90"},
                             "status"=>"confirmed"}},
                {"title"=>"Condition Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Condition/%2Ftenant%3Ad075cf8b-3261-481d-97e5-ba6c48d3b41f_0%2Fperson%3A3602355%2Fclinicalfacts.condition.type%3ACODIFIED%2Fid%3A14626798",
                 "content"=>{"resourceType"=>"Condition",
                             "contained"=>[{"resourceType"=>"Practitioner",
                                            "id"=>"practitioner1293205",
                                            "name"=>{"text"=>"Norton RN, Rona"},
                                            "organization"=>{"display"=>"Cerner Medical Center"}}],
                             "subject"=>{"reference"=>"Patient/3602355"},
                             "asserter"=>{"reference"=>"#practitioner1293205",
                                          "display"=>"Norton RN, Rona"},
                             "code"=>{"coding"=>[{"system"=>"http://hl7.org/fhir/sid/icd-9",
                                                  "code"=>"714.0",
                                                  "display"=>"Rheumatoid arthritis"}],
                                      "text"=>"Rheumatoid arthritis"},
                             "status"=>"confirmed"}}]
    }

    DSTU1_DIAGNOSTIC_REPORT_BUNDLE ||= {
      "resourceType"=>"Bundle",
      "title"=>"Search results for resource type DiagnosticReport",
      "id"=>"63cb5365-149c-4851-897e-b4b4c54a1512",
      "link"=>[{"rel"=>"self",
                "href"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport?subject:Patient=3602356"}],
      "updated"=>"2015-04-03T16:47:27.614+00:00",
      "author"=>[{"name"=>"Cerner Corporation"}],
      "entry"=>[{"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117766",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"30745-4"},
                                                 {"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Chest 2 Views"},
                             "status"=>"final",
                             "issued"=>"2013-09-15T19:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:Cough;Shortness of breath  (SOB)     ReportHistory: left sided rib pain, lower left anterior and posterior     Technique: PA and lateral views of the chest were performed. Comparison is made to a prior study dated 5/30/07.     Findings: The lungs are clear and well expanded. No acute infiltrate, pleural effusion, or pneumothorax is identified. There is normal vascularity. The cardiovascular silhouette is within normal limits. Visualized bones and soft tissues are unremarkable. No displaced rib fractures are seen.     Impression: There is no evidence of acute cardiopulmonary disease.   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:35 pm  Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117663",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Chest 1 View"},
                             "status"=>"final",
                             "issued"=>"2013-03-07T20:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:Chest pain     ReportHistory: Chest pain.     Findings: An AP supine view of the chest was acquired and compared with prior PA erect examination dated 9/1/10. The cardiac silhouette and pulmonary vascular pattern are within normal limits for the supine position. The lungs are clear of infiltrates. No displaced rib fractures are identified. There is subluxation of the right humeral head which is unchanged since the prior exam.     Impression: No pulmonary infiltrates or congestive failure.   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:17 pm Transcribed by: MRW Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117703",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Foot Complete Left"},
                             "status"=>"final",
                             "issued"=>"2013-06-03T19:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:left foot swelling     ReportHistory: Cellulitis left leg, rheumatoid arthritis, rule out gas producing organ     Findings: A PA PA oblique and lateral views show soft tissue generally over the foot, predominantly dorsally. There is mild generalized demineralization of bony parts. No other specific abnormalities are noted.     Impression: I do not identify radiopaque foreign body or gas within the soft tissues.\"   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:24 pm  Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117681",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Wrist Complete Left"},
                             "status"=>"final",
                             "issued"=>"2013-09-12T19:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:Follow up fracture     ReportHistory: Indication is followup fracture.     Findings: Two views are compared to 06/15/12. A distal left radial fracture site shows continued healing in otherwise unchanged appearance and alignment from the September examination.     Impression: Negative wrist   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:20 pm  Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117734",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Hand Complete Left"},
                             "status"=>"final",
                             "issued"=>"2013-07-19T19:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:post injury eval     ReportHistory: Post injury evaluation.     Technique: Three views submitted.     Findings: Osseous structures appear intact and normally aligned.     Impression: Negative hand   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:28 pm  Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117905",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Foot Complete Left"},
                             "status"=>"final",
                             "issued"=>"2013-05-22T19:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:left foot pain     ReportHistory: left foot pain.     Findings: Examination of the left foot shows a spur on the inferior pole of the calcaneus. There is no evidence of fracture or bone disease.     Impression: Spur formation left calcaneus.   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:59 pm  Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117623",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Foot Complete Left"},
                             "status"=>"final",
                             "issued"=>"2013-03-07T20:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:foot pain     ReportHistory: Pain.     Findings: Interval appearance is unchanged. There is a stable plantar spur. Midfoot degenerative changes are associated with a pes planus alignment.     Impression:Forefoot unremarkable and no acute pathology is seen.\"   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:17 pm Transcribed by: MRW Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117779",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Hand 2 Views Bilateral"},
                             "status"=>"final",
                             "issued"=>"2013-12-27T20:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:pain in both hands     ReportHISTORY: Female pain in both hands/history of auto immune disease for few years.     TECHNIQUE: 2 views of the hands are submitted for evaluation.     COMPARISON: None     FINDINGS: RIGHT: Irregular joint space narrowing around the DIP joint of the second and third digit, with central erosion and peripheral bony proliferation, most indicative of erosive osteoarthritis. Osteoarthritic changes with subchondral cysts are also noted at the PIP joint of the third, fourth and fifth digits, the triscaphe joint, the first through fourth MCP joints, and the interphalangeal joint of the thumb. Osseous structures are osteopenic. LEFT: Irregular joint space narrowing around PIP of the second digit and to a lesser extent of the fifth digit with central erosion and peripheral bony proliferation, most indicative of erosive osteoarthritis. Osteoarthritic changes with subchondral cyst also noted at the PIP of the fifth digit, triscaphe joint, first, third and fourth MCP joints, and the interphalangeal joint of the thumb. Osseous structures are osteopenic. Cystic changes at the proximal ulnar aspect of the lunate may be from ulnar abutment.     IMPRESSION: Bilateral erosive osteoarthritis (R&gt;L). Possible left ulnar abutment syndrome   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:43 pm  Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117749",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"30745-4"},
                                                 {"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Chest 2 Views"},
                             "status"=>"final",
                             "issued"=>"2013-06-10T19:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:left side pain;Shortness of breath  (SOB)     ReportHistory: left sided rib pain, lower left anterior and posterior     Technique: PA and lateral views of the chest were performed. Comparison is made to a prior study dated 5/30/07.     Findings: The lungs are clear and well expanded. No acute infiltrate, pleural effusion, or pneumothorax is identified. There is normal vascularity. The cardiovascular silhouette is within normal limits. Visualized bones and soft tissues are unremarkable. No displaced rib fractures are seen.     Impression: There is no evidence of acute cardiopulmonary disease.\"   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:33 pm  Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117788",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Hand 2 Views Bilateral"},
                             "status"=>"final",
                             "issued"=>"2014-03-11T19:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:pain     ReportHistory: Bilateral hand pain.     Findings: Examination of the hands and wrists shows advanced arthritic changes of the distal interphalangeal joints of these second third fourth and fifth fingers and the interphalangeal joint of the first finger. The wrists appear normal. Impression: Advanced arthritic changes both hands.     Impression: Negative wrists.   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:46 pm  Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117861",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"BD Bone Density DEXA Body Composition"},
                             "status"=>"final",
                             "issued"=>"2014-05-28T19:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:Eval     ReportHistory: Advanced arthritic changes.     Findings: A spine bone density value in the range 80-120 mg/cm3 is indicative of osteopenia. The risk for fracture goes up as the bone density goes down, and some, but not all, individuals with BMD in the lower end of this range will have vertebral fractures.     Impression: Level(s) normal.   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:52 pm  Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117694",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"30745-4"},
                                                 {"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Chest 2 Views"},
                             "status"=>"final",
                             "issued"=>"2014-01-19T20:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:shortness of breath;Shortness of breath  (SOB)     ReportHistory:shortness of breath with exertion     Technique: CHEST 2 VIEWS AP OR PA AND LATERAL -- 05/10/12 PA and lateral views of the chest were acquired and compared with the prior examination dated 10/16/10.     Findings: The cardiomediastinal silhouette is within normal limits of size and configuration. The pulmonary vascular pattern is normal. The lungs are clear infiltrates. There are no pleural effusions. Degenerative changes of the thoracic spine are stable.     Impression: No active cardiopulmonary disease.\"   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:23 pm  Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117870",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Foot 2 Views Bilateral"},
                             "status"=>"final",
                             "issued"=>"2014-05-19T19:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:pain     AddendumThere are spurs on the inferior pole of the calcanei bilaterally.   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:56 pm  Technologist     ReportHistory: Bilateral Foot pain after fall.     Findings: Examination of the feet shows no evidence of fracture or bone disease.     Impression: Negative feet.   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:54 pm  Technologist"}},
                {"title"=>"DiagnosticReport Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport/6117718",
                 "content"=>{"resourceType"=>"DiagnosticReport",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"169074008"}],
                                      "text"=>"XR Hand 2 Views Right | XR Wrist 2 Views Right"},
                             "status"=>"final",
                             "issued"=>"2013-07-19T19:40:34.000Z",
                             "subject"=>{"reference"=>"Patient/3602356"},
                             "conclusion"=>"Reason for exam:rt hand swelling      Reason for exam:rt hand swelling     ReportHistory: RIGHT HAND SWELLING ?? RA CHANGES, ? OA ?? CPPD? OTHER. OTHER MALAISE AND FATIGUE . PAIN IN JOINT INVOLVING MULTIPLE SITES. Muscle weakness (generalized)     Technique: Two views of the right hand are submitted for interpretation. COMPARISON: 9/5/09     Findings: Posttraumatic changes are again noted involving the distal radius with radiocarpal joint space narrowing. There is mild sclerosis and joint space narrowing at the first carpometacarpal joint. Similar changes are present at the first MCP. There is mild joint space narrowing of the DIP joints without erosions. No erosive changes can be identified within the limits of the study. No significant soft tissue calcifications are identified.     Impression: 1. Posttraumatic changes involving the distal radius. 2. Osteoarthritic changes as detailed above.\"   Signature Line:***** Final *****    Signed by:  Wilson MD, Mark R Signed (Electronic Signature):  03/27/2015 3:27 pm  Technologist"}}]
    }

    DSTU1_ENCOUNTER ||= {
      "resourceType"=>"Encounter",
      "identifier"=>[{"use"=>"usual",
                      "label"=>"FIN NBR",
                      "system"=>"http://cerner.com/fhir/identifier/FINNBR",
                      "value"=>"000022371"}],
      "subject"=>{"reference"=>"Patient/3602355"},
      "participant"=>[{"type"=>[{"coding"=>[{"system"=>"http://hl7.org/fhir/v3/ParticipationType",
                                             "code"=>"ATND",
                                             "display"=>"attender"}],
                                 "text"=>"attender"}],
                       "individual"=>{"display"=>"Knight MD, Wayne"}}],
      "period"=>{"start"=>"2015-03-12T15:30:00.000Z",
                 "end"=>"2015-03-13T04:59:59.000Z"},
      "location"=>[{"location"=>{"display"=>"BW IR"},
                    "period"=>{"start"=>"2015-03-12T15:30:00.000Z",
                               "end"=>"2015-03-13T04:59:59.000Z"}}]
    }

    DSTU1_ENCOUNTER_BUNDLE ||= {
      "resourceType"=>"Bundle",
      "title"=>"Search results for resource type Encounter",
      "id"=>"796e55e8-ed84-4480-ba05-7de545c86e02",
      "link"=>[{"rel"=>"self",
                "href"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Encounter?subject:Patient=3602355"}],
      "updated"=>"2015-04-02T17:21:25.255+00:00",
      "author"=>[{"name"=>"Cerner Corporation"}],
      "entry"=>[{"title"=>"Encounter Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Encounter/3524878",
                 "content"=>DSTU1_ENCOUNTER}]
    }

    DSTU1_IMMUNIZATION_BUNDLE ||= {
      "resourceType"=>"Bundle",
      "title"=>"Search results for resource type Immunization",
      "id"=>"27780a25-18ba-4fd8-9c18-e3beb215d2c2",
      "link"=>[{"rel"=>"self",
                "href"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Immunization?subject:Patient=3602356"}],
      "updated"=>"2015-04-02T17:16:33.685+00:00",
      "author"=>[{"name"=>"Cerner Corporation"}],
      "entry"=>[{"title"=>"Immunization Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Immunization/6109433",
                 "content"=>{"resourceType"=>"Immunization",
                             "date"=>"2014-03-11T20:00:00.000Z",
                             "vaccineType"=>{"coding"=>[{"system"=>"http://hl7.org/fhir/v3/VaccineType",
                                                         "code"=>"88"}],
                                             "text"=>"Fluzone Intradermal 2013-2014"},
                             "refusedIndicator"=>false,
                             "reported"=>false,
                             "subject"=>{"reference"=>"Patient/3602356"}}}]
    }

    DSTU1_MEDICATION_PRESCRIPTION_BUNDLE ||= {
      "resourceType"=>"Bundle",
      "title"=>"Search results for resource type MedicationPrescription",
      "id"=>"2547d0ae-86f2-4efc-b66a-117ed3693f08",
      "link"=>[{"rel"=>"self",
                "href"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/MedicationPrescription?patient=3602355"}],
      "updated"=>"2015-04-02T17:25:00.506+00:00",
      "author"=>[{"name"=>"Cerner Corporation"}],
      "entry"=>[{"title"=>"MedicationPrescription Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/MedicationPrescription/24218117",
                 "content"=>{"resourceType"=>"MedicationPrescription",
                             "contained"=>[{"resourceType"=>"Medication",
                                            "id"=>"2763106",
                                            "code"=>{"coding"=>[{"system"=>"http://www.nlm.nih.gov/research/umls/rxnorm",
                                                                 "code"=>"105586",
                                                                 "display"=>"Methotrexate 10 MG Oral Tablet"}],
                                                     "text"=>"methotrexate 10 mg oral tablet"},
                                            "name"=>"methotrexate 10 mg oral tablet"}],
                             "status"=>"active",
                             "patient"=>{"reference"=>"Patient/3602355"},
                             "prescriber"=>{"reference"=>"Practitioner/3602366",
                                            "display"=>"Knight MD, Wayne"},
                             "medication"=>{"reference"=>"#2763106",
                                            "display"=>"methotrexate 10 mg oral tablet"},
                             "dosageInstruction"=>[{"text"=>"2 tabs, Oral, qWeek, 90 tabs, 0 Refill(s)",
                                                    "timingPeriod"=>{"start"=>"2014-05-01T19:00:00.000Z"}}],
                             "dispense"=>{"medication"=>{"reference"=>"#2763106",
                                                         "display"=>"methotrexate 10 mg oral tablet"},
                                          "quantity"=>{"value"=>"90",
                                                       "units"=>"tabs"}}}},
                {"title"=>"MedicationPrescription Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/MedicationPrescription/24218151",
                 "content"=>{"resourceType"=>"MedicationPrescription",
                             "contained"=>[{"resourceType"=>"Medication",
                                            "id"=>"2767469",
                                            "code"=>{"coding"=>[{"system"=>"http://www.nlm.nih.gov/research/umls/rxnorm",
                                                                 "code"=>"312617",
                                                                 "display"=>"Prednisone 5 MG Oral Tablet"}],
                                                     "text"=>"predniSONE 5 mg oral tablet"},
                                            "name"=>"predniSONE 5 mg oral tablet"}],
                             "status"=>"active",
                             "patient"=>{"reference"=>"Patient/3602355"},
                             "prescriber"=>{"reference"=>"Practitioner/3602366",
                                            "display"=>"Knight MD, Wayne"},
                             "medication"=>{"reference"=>"#2767469",
                                            "display"=>"predniSONE 5 mg oral tablet"},
                             "dosageInstruction"=>[{"text"=>"1 tabs, Oral, Daily, 30 tabs, 0 Refill(s)",
                                                    "timingPeriod"=>{"start"=>"2013-03-01T15:00:00.000Z"}}],
                             "dispense"=>{"medication"=>{"reference"=>"#2767469",
                                                         "display"=>"predniSONE 5 mg oral tablet"},
                                          "quantity"=>{"value"=>"30",
                                                       "units"=>"tabs"}}}},
                {"title"=>"MedicationPrescription Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/MedicationPrescription/24218187",
                 "content"=>{"resourceType"=>"MedicationPrescription",
                             "contained"=>[{"resourceType"=>"Medication",
                                            "id"=>"2762241",
                                            "code"=>{"coding"=>[{"system"=>"http://www.nlm.nih.gov/research/umls/rxnorm",
                                                                 "code"=>"314076",
                                                                 "display"=>"Lisinopril 10 MG Oral Tablet"}],
                                                     "text"=>"lisinopril 10 mg oral tablet"},
                                            "name"=>"lisinopril 10 mg oral tablet"}],
                             "status"=>"active",
                             "patient"=>{"reference"=>"Patient/3602355"},
                             "prescriber"=>{"reference"=>"Practitioner/3602366",
                                            "display"=>"Knight MD, Wayne"},
                             "medication"=>{"reference"=>"#2762241",
                                            "display"=>"lisinopril 10 mg oral tablet"},
                             "dosageInstruction"=>[{"text"=>"1 tabs, Oral, Daily, 60 tabs",
                                                    "timingPeriod"=>{"start"=>"2013-06-07T14:00:00.000Z"}}],
                             "dispense"=>{"medication"=>{"reference"=>"#2762241",
                                                         "display"=>"lisinopril 10 mg oral tablet"},
                                          "quantity"=>{"value"=>"60",
                                                       "units"=>"tabs"}}}}]
    }

    DSTU1_OPEN_METADATA ||= {"resourceType"=>"Conformance",
                  "text"=>{"status"=>"generated",
                           "div"=>"Generated Conformance Statement"},
                  "identifier"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Conformance",
                  "name"=>"SMART on FHIR Conformance Statement",
                  "publisher"=>"Cerner",
                  "description"=>"Describes capabilities of this server",
                  "status"=>"draft",
                  "date"=>"2015-04-02T16:02:06.144+00:00",
                  "fhirVersion"=>"0.0.82",
                  "acceptUnknown"=>false,
                  "format"=>["json"],
                  "rest"=>[{"mode"=>"server",
                            "documentation"=>"All the functionality defined in FHIR",
                            "security"=>{"cors"=>true}}]}

    DSTU1_AUTH_METADATA ||= {
      "resourceType"=>"Conformance",
      "text"=>{"status"=>"generated",
               "div"=>"Generated Conformance Statement"},
      "identifier"=>"https://fhir.sandboxcernerpowerchart.com/fhir/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Conformance",
      "name"=>"SMART on FHIR Conformance Statement",
      "publisher"=>"Cerner",
      "description"=>"Describes capabilities of this server",
      "status"=>"draft",
      "date"=>"2015-04-03T16:37:34.559+00:00",
      "fhirVersion"=>"0.0.82",
      "acceptUnknown"=>false,
      "format"=>["json"],
      "rest"=>[{"mode"=>"server",
                "documentation"=>"All the functionality defined in FHIR",
                "security"=>{"extension"=>[{"url"=>"http://fhir-registry.smarthealthit.org/Profile/oauth-uris#token",
                                            "valueUri"=>"https://fhir.sandboxcernerpowerchart.com/oauth2/token"},
                                           {"url"=>"http://fhir-registry.smarthealthit.org/Profile/oauth-uris#authorize",
                                            "valueUri"=>"https://fhir.sandboxcernerpowerchart.com/oauth2/authorize"}],
                             "cors"=>true,
                             "service"=>[{"coding"=>[{"system"=>"http://hl7.org/fhir/vs/restful-security-service",
                                                      "code"=>"OAuth2"}],
                                          "text"=>"OAuth version 2"}],
                             "description"=>"SMART on FHIR uses OAuth2 for authorization"}}]
    }

    DSTU1_OBSERVATION_BUNDLE ||= {
      "resourceType"=>"Bundle",
      "title"=>"Search results for resource type Observation",
      "id"=>"15262c30-ec5a-4ab5-a2ac-d5d879d1f180",
      "link"=>[{"rel"=>"self",
                "href"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation?subject:Patient=3602355"}],
      "updated"=>"2015-04-02T17:30:45.739+00:00",
      "author"=>[{"name"=>"Cerner Corporation"}],
      "entry"=>[{"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6116990",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"35591-7"}],
                                      "text"=>"Estimated Creatinine Clearance"},
                             "valueQuantity"=>{"value"=>37.83,
                                               "units"=>"mL/min",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"mL/min"},
                             "appliesDateTime"=>"2015-03-27T19:08:15.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6116935",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"35591-7"}],
                                      "text"=>"Estimated Creatinine Clearance"},
                             "valueQuantity"=>{"value"=>30.26,
                                               "units"=>"mL/min",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"mL/min"},
                             "appliesDateTime"=>"2015-03-27T19:06:35.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6116966",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"2160-0"}],
                                      "text"=>"Creatinine Lvl"},
                             "valueQuantity"=>{"value"=>1.2,
                                               "units"=>"mg/dL",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"mg/dL"},
                             "appliesDateTime"=>"2015-03-15T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6116978",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"1751-7"}],
                                      "text"=>"Albumin Lvl"},
                             "valueQuantity"=>{"value"=>4.1,
                                               "units"=>"g/dL",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"g/dL"},
                             "appliesDateTime"=>"2015-03-15T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6116982",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"6768-6"}],
                                      "text"=>"Alk Phos"},
                             "valueQuantity"=>{"value"=>91.0,
                                               "units"=>"IU/L",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"[iU]/d"},
                             "appliesDateTime"=>"2015-03-15T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6116974",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"1920-8"}],
                                      "text"=>"AST"},
                             "valueQuantity"=>{"value"=>33.0,
                                               "units"=>"unit/L"},
                             "appliesDateTime"=>"2015-03-15T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6116970",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"1742-6"}],
                                      "text"=>"ALT"},
                             "valueQuantity"=>{"value"=>26.0,
                                               "units"=>"unit/L"},
                             "appliesDateTime"=>"2015-03-15T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6117004",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"48642-3"}],
                                      "text"=>"eGFR Non-AA"},
                             "valueQuantity"=>{"value"=>47.0,
                                               "units"=>"mL/min/1.73 m2"},
                             "appliesDateTime"=>"2015-03-15T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6117002",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"48643-1"}],
                                      "text"=>"eGFR AA"},
                             "valueQuantity"=>{"value"=>57.0,
                                               "units"=>"mL/min/1.73 m2"},
                             "appliesDateTime"=>"2015-03-15T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6166221",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"6690-2"}],
                                      "text"=>"WBC"},
                             "valueQuantity"=>{"value"=>6.6,
                                               "units"=>"x10^3/mcL"},
                             "appliesDateTime"=>"2015-03-15T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6116986",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"718-7"}],
                                      "text"=>"Hgb"},
                             "valueQuantity"=>{"value"=>11.3,
                                               "units"=>"%",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"%"},
                             "appliesDateTime"=>"2015-03-15T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6116988",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"4544-3"}],
                                      "text"=>"Hct"},
                             "valueQuantity"=>{"value"=>33.9,
                                               "units"=>"%",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"%"},
                             "appliesDateTime"=>"2015-03-15T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6116998",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"777-3"}],
                                      "text"=>"Platelet"},
                             "valueQuantity"=>{"value"=>121.0,
                                               "units"=>"x10^3/mcL"},
                             "appliesDateTime"=>"2015-03-15T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6165413",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"6690-2"}],
                                      "text"=>"WBC"},
                             "valueQuantity"=>{"value"=>4.9,
                                               "units"=>"x10^3/mcL"},
                             "appliesDateTime"=>"2015-03-12T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6139238",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"11572-5"}],
                                      "text"=>"RA"},
                             "valueQuantity"=>{"value"=>160.0,
                                               "units"=>"IU/mL",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"[iU]/mL"},
                             "appliesDateTime"=>"2015-03-12T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6116005",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"415945006"},
                                                 {"system"=>"http://loinc.org/",
                                                  "code"=>"8310-5"}],
                                      "text"=>"Temperature Oral"},
                             "valueQuantity"=>{"value"=>39.0,
                                               "units"=>"degC",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"Cel"},
                             "appliesDateTime"=>"2015-03-12T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6115477",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"50373000"},
                                                 {"system"=>"http://loinc.org/",
                                                  "code"=>"8302-2"}],
                                      "text"=>"Height/Length Measured"},
                             "valueQuantity"=>{"value"=>149.86,
                                               "units"=>"cm",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"cm"},
                             "appliesDateTime"=>"2015-03-12T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6115882",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"54718008"},
                                                 {"system"=>"http://loinc.org/",
                                                  "code"=>"8867-4"}],
                                      "text"=>"Peripheral Pulse Rate"},
                             "valueQuantity"=>{"value"=>69.0,
                                               "units"=>"bpm"},
                             "appliesDateTime"=>"2015-03-12T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6115622",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"60621009"},
                                                 {"system"=>"http://loinc.org/",
                                                  "code"=>"39156-5"}],
                                      "text"=>"Body Mass Index Measured"},
                             "valueQuantity"=>{"value"=>24.64,
                                               "units"=>"kg/m2",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"kg/m2"},
                             "appliesDateTime"=>"2015-03-12T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6115618",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"27113001"},
                                                 {"system"=>"http://loinc.org/",
                                                  "code"=>"3141-9"}],
                                      "text"=>"Weight Measured"},
                             "valueQuantity"=>{"value"=>55.34,
                                               "units"=>"kg",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"kg"},
                             "appliesDateTime"=>"2015-03-12T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6115135",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"271649006"},
                                                 {"system"=>"http://loinc.org/",
                                                  "code"=>"8480-6"}],
                                      "text"=>"Systolic Blood Pressure"},
                             "valueQuantity"=>{"value"=>141.0,
                                               "units"=>"mmHg",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"mm[Hg]"},
                             "appliesDateTime"=>"2015-03-12T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/6115137",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://snomed.info/sct",
                                                  "code"=>"271650006"},
                                                 {"system"=>"http://loinc.org/",
                                                  "code"=>"8462-4"}],
                                      "text"=>"Diastolic Blood Pressure"},
                             "valueQuantity"=>{"value"=>91.0,
                                               "units"=>"mmHg",
                                               "system"=>"http://unitsofmeasure.org",
                                               "code"=>"mm[Hg]"},
                             "appliesDateTime"=>"2015-03-12T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"}}},
                {"title"=>"Observation Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation/grouper%253A6115135%253A6115137",
                 "content"=>{"resourceType"=>"Observation",
                             "name"=>{"coding"=>[{"system"=>"http://loinc.org/",
                                                  "code"=>"55284-4"},
                                                 {"system"=>"http://snomed.info/sct",
                                                  "code"=>"75367002"}],
                                      "text"=>"Blood Pressure"},
                             "appliesDateTime"=>"2015-03-12T14:00:00.000Z",
                             "status"=>"final",
                             "reliability"=>"ok",
                             "subject"=>{"reference"=>"Patient/3602355"},
                             "related"=>[{"type"=>"has-component",
                                          "target"=>{"reference"=>"Observation/6115135"}},
                                         {"type"=>"has-component",
                                          "target"=>{"reference"=>"Observation/6115137"}}]}}]
    }

    DSTU1_PATIENT ||= {
      "resourceType"=>"Patient",
      "extension"=>[{"url"=>"http://cerner.com/fhir/extension/race",
                     "valueCodeableConcept"=>{"coding"=>[{"system"=>"http://cerner.com/fhir/valueset/race",
                                                          "display"=>"White"}],
                                              "text"=>"White"}}],
      "identifier"=>[{"use"=>"usual",
                      "label"=>"MRN",
                      "system"=>"http://cerner.com/fhir/identifier/MRN",
                      "value"=>"00004717"}],
      "name"=>[{"use"=>"usual",
                "text"=>"LOGGER, KIM",
                "family"=>["LOGGER"],
                "given"=>["KIM"],
                "suffix"=>[]}],
      "telecom"=>[{"system"=>"phone",
                   "value"=>"(816) 555-2312",
                   "use"=>"home"}],
      "gender"=>{"coding"=>[{"system"=>"http://hl7.org/fhir/v3/AdministrativeGender",
                             "code"=>"F",
                             "display"=>"Female"}]},
      "birthDate"=>"1963-06-17",
      "deceasedBoolean"=>false,
      "photo"=>[],
      "address"=>[{"use"=>"home",
                   "text"=>"10236 MARION PARK DR\nKANSAS CITY, MO 64137-1405\nUS",
                   "line"=>["10236 MARION PARK DR"],
                   "city"=>"KANSAS CITY",
                   "state"=>"MO",
                   "zip"=>"64137-1405"}],
      "contact"=>[],
      "careProvider"=>[{"reference"=>"Practitioner/3602366",
                        "display"=>"Knight MD, Wayne"}]
    }

    DSTU1_PATIENT_BUNDLE ||= {
      "resourceType"=>"Bundle",
      "title"=>"Search results for resource type Patient",
      "id"=>"f9c97ac7-4802-4cf5-b54a-3de57646ab5d",
      "link"=>[{"rel"=>"self",
                "href"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Patient?name=Logger&start=0&max=20"}],
      "updated"=>"2015-04-02T17:28:49.462+00:00",
      "author"=>[{"name"=>"Cerner Corporation"}],
      "entry"=>[{"title"=>"Patient Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Patient/3602355",
                 "content"=>DSTU1_PATIENT},
                {"title"=>"Patient Entry",
                 "id"=>"https://fhir.sandboxcernerpowerchart.com/fhir/open/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Patient/3582172",
                 "content"=>{"resourceType"=>"Patient",
                             "identifier"=>[{"use"=>"usual",
                                             "label"=>"MRN",
                                             "system"=>"http://cerner.com/fhir/identifier/MRN",
                                             "value"=>"00002803"}],
                             "name"=>[{"use"=>"usual",
                                       "text"=>"Lucero, Bryan",
                                       "family"=>["Lucero"],
                                       "given"=>["Bryan"],
                                       "suffix"=>[]}],
                             "telecom"=>[],
                             "gender"=>{"coding"=>[{"system"=>"http://hl7.org/fhir/v3/AdministrativeGender",
                                                    "code"=>"M",
                                                    "display"=>"Male"}]},
                             "birthDate"=>"1929-11-02",
                             "deceasedBoolean"=>false,
                             "photo"=>[],
                             "address"=>[],
                             "contact"=>[],
                             "careProvider"=>[{"reference"=>"Practitioner/1315931",
                                               "display"=>"Ahmad MD, James"}]}}]
    }

    # MAY 2015 BALLOT JSON

    MAY2015_OPEN_METADATA ||= {
        "resourceType"=> "Conformance",
        "text"=> {
            "status"=> "generated",
            "div"=> "&lt;div>Generated Conformance Statement&lt;/div>"
        },
        "url"=> "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/metadata",
        "name"=> "Cerner Conformance Statement",
        "publisher"=> "Cerner",
        "description"=> "Describes capabilities of this server",
        "status"=> "draft",
        "date"=> "2015-10-09T19:12:45.663+00:00",
        "fhirVersion"=> "0.5.0",
        "acceptUnknown"=> false,
        "format"=> ["json"],
        "rest"=> [{
                      "mode"=> "server",
                      "documentation"=> "All the functionality defined in FHIR",
                      "security"=> {
                          "cors"=> true
                      },
                      "resource"=> [{
                                        "type"=> "AllergyIntolerance",
                                        "interaction"=> [{
                                                             "code"=> "search-type"
                                                         }],
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "Who the sensitivity is for"
                                                         }, {
                                                             "name"=> "status",
                                                             "type"=> "token",
                                                             "documentation"=> "The status of the allergy"
                                                         }]
                                    }, {
                                        "type"=> "Condition",
                                        "interaction"=> [{
                                                             "code"=> "search-type"
                                                         }],
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "Who has the condition?"
                                                         }, {
                                                             "name"=> "subject",
                                                             "type"=> "reference",
                                                             "documentation"=> "Who has the condition?"
                                                         }, {
                                                             "name"=> "clinicalstatus",
                                                             "type"=> "token",
                                                             "documentation"=> "The clinical status of the condition"
                                                         }, {
                                                             "name"=> "category",
                                                             "type"=> "token",
                                                             "documentation"=> "The category of the condition"
                                                         }]
                                    }, {
                                        "type"=> "DiagnosticReport",
                                        "interaction"=> [{
                                                             "code"=> "search-type"
                                                         }],
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "The subject of the report if a patient"
                                                         }, {
                                                             "name"=> "subject",
                                                             "type"=> "reference",
                                                             "documentation"=> "The subject of the report"
                                                         }]
                                    }, {
                                        "type"=> "Encounter",
                                        "interaction"=> [{
                                                             "code"=> "read"
                                                         }, {
                                                             "code"=> "search-type"
                                                         }],
                                        "readHistory"=> false,
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "The patient present at the encounter"
                                                         }]
                                    }, {
                                        "type"=> "Immunization",
                                        "interaction"=> [{
                                                             "code"=> "search-type"
                                                         }],
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "The patient for the vaccination record"
                                                         }]
                                    }, {
                                        "type"=> "MedicationPrescription",
                                        "interaction"=> [{
                                                             "code"=> "search-type"
                                                         }],
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "The identity of a patient to list dispenses for"
                                                         }, {
                                                             "name"=> "status",
                                                             "type"=> "token",
                                                             "documentation"=> "The status of the prescription"
                                                         }, {
                                                             "name"=> "scheduledtiming-bounds-end",
                                                             "type"=> "date",
                                                             "documentation"=> "The period end of the prescription timing schedule. This parameter value should be prefixed by &lt;="
                                                         }, {
                                                             "name"=> "_count",
                                                             "type"=> "number",
                                                             "documentation"=> "The maximum number of results to return"
                                                         }]
                                    }, {
                                        "type"=> "Observation",
                                        "interaction"=> [{
                                                             "code"=> "search-type"
                                                         }],
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "The subject that the observation is about (if patient)"
                                                         }, {
                                                             "name"=> "subject",
                                                             "type"=> "reference",
                                                             "documentation"=> "The subject that the observation is about"
                                                         }, {
                                                             "name"=> "code",
                                                             "type"=> "token",
                                                             "documentation"=> "The type of observation"
                                                         }, {
                                                             "name"=> "date",
                                                             "type"=> "date",
                                                             "documentation"=> "The date range into which the observation falls. This parameter value should be present twice, prefixed once by '>' representing the earliest date and once by '&lt;' representing the latest date."
                                                         }]
                                    }, {
                                        "type"=> "Patient",
                                        "interaction"=> [{
                                                             "code"=> "read"
                                                         }, {
                                                             "code"=> "search-type"
                                                         }],
                                        "readHistory"=> false,
                                        "searchParam"=> [{
                                                             "name"=> "_id",
                                                             "type"=> "token",
                                                             "documentation"=> "The logical resource id associated with the resource (must be supported by all servers)"
                                                         }, {
                                                             "name"=> "birthdate",
                                                             "type"=> "date",
                                                             "documentation"=> "The patient's date of birth"
                                                         }, {
                                                             "name"=> "identifier",
                                                             "type"=> "token",
                                                             "documentation"=> "A patient identifier"
                                                         }, {
                                                             "name"=> "name",
                                                             "type"=> "string",
                                                             "documentation"=> "A portion of either family or given name of the patient"
                                                         }, {
                                                             "name"=> "telecom",
                                                             "type"=> "string",
                                                             "documentation"=> "The value in any kind of telecom details of the patient"
                                                         }, {
                                                             "name"=> "start",
                                                             "type"=> "number",
                                                             "documentation"=> "The offset to use when returning results"
                                                         }, {
                                                             "name"=> "_count",
                                                             "type"=> "number",
                                                             "documentation"=> "The maximum number of results to return"
                                                         }]
                                    }]
                  }]
    }


    MAY2015_AUTH_METADATA ||= {
        "resourceType"=> "Conformance",
        "text"=> {
            "status"=> "generated",
            "div"=> "&lt;div>Generated Conformance Statement&lt;/div>"
        },
        "url"=> "https://fhir.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/metadata",
        "name"=> "Cerner Conformance Statement",
        "publisher"=> "Cerner",
        "description"=> "Describes capabilities of this server",
        "status"=> "draft",
        "date"=> "2015-10-09T19:11:41.476+00:00",
        "fhirVersion"=> "0.5.0",
        "acceptUnknown"=> false,
        "format"=> ["json"],
        "rest"=> [{
                      "mode"=> "server",
                      "documentation"=> "All the functionality defined in FHIR",
                      "security"=> {
                          "extension"=> [{
                                             "url"=> "http://fhir-registry.smarthealthit.org/StructureDefinition/oauth-uris",
                                             "extension"=> [{
                                                                "url"=> "token",
                                                                "valueUri"=> "https://authorization.sandboxcerner.com/realms/d075cf8b-3261-481d-97e5-ba6c48d3b41f/protocols/smart/token"
                                                            }, {
                                                                "url"=> "authorize",
                                                                "valueUri"=> "https://authorization.sandboxcerner.com/realms/d075cf8b-3261-481d-97e5-ba6c48d3b41f/protocols/smart/authorize"
                                                            }]
                                         }],
                          "cors"=> true,
                          "service"=> [{
                                           "coding"=> [{
                                                           "system"=> "http://hl7.org/fhir/vs/restful-security-service",
                                                           "code"=> "OAuth2"
                                                       }],
                                           "text"=> "OAuth version 2 (see oauth.net)."
                                       }],
                          "description"=> "OAuth2 plus SMART extensions"
                      },
                      "resource"=> [{
                                        "type"=> "AllergyIntolerance",
                                        "interaction"=> [{
                                                             "code"=> "search-type"
                                                         }],
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "Who the sensitivity is for"
                                                         }, {
                                                             "name"=> "status",
                                                             "type"=> "token",
                                                             "documentation"=> "The status of the allergy"
                                                         }]
                                    }, {
                                        "type"=> "Condition",
                                        "interaction"=> [{
                                                             "code"=> "create"
                                                         }, {
                                                             "code"=> "search-type"
                                                         }],
                                        "updateCreate"=> false,
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "Who has the condition?"
                                                         }, {
                                                             "name"=> "subject",
                                                             "type"=> "reference",
                                                             "documentation"=> "Who has the condition?"
                                                         }, {
                                                             "name"=> "clinicalstatus",
                                                             "type"=> "token",
                                                             "documentation"=> "The clinical status of the condition"
                                                         }, {
                                                             "name"=> "category",
                                                             "type"=> "token",
                                                             "documentation"=> "The category of the condition"
                                                         }]
                                    }, {
                                        "type"=> "DiagnosticReport",
                                        "interaction"=> [{
                                                             "code"=> "search-type"
                                                         }],
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "The subject of the report if a patient"
                                                         }, {
                                                             "name"=> "subject",
                                                             "type"=> "reference",
                                                             "documentation"=> "The subject of the report"
                                                         }]
                                    }, {
                                        "type"=> "DocumentReference",
                                        "interaction"=> [{
                                                             "code"=> "create"
                                                         }],
                                        "updateCreate"=> false
                                    }, {
                                        "type"=> "Encounter",
                                        "interaction"=> [{
                                                             "code"=> "read"
                                                         }, {
                                                             "code"=> "search-type"
                                                         }],
                                        "readHistory"=> false,
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "The patient present at the encounter"
                                                         }]
                                    }, {
                                        "type"=> "Immunization",
                                        "interaction"=> [{
                                                             "code"=> "search-type"
                                                         }],
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "The patient for the vaccination record"
                                                         }]
                                    }, {
                                        "type"=> "MedicationPrescription",
                                        "interaction"=> [{
                                                             "code"=> "search-type"
                                                         }],
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "The identity of a patient to list dispenses for"
                                                         }, {
                                                             "name"=> "status",
                                                             "type"=> "token",
                                                             "documentation"=> "The status of the prescription"
                                                         }, {
                                                             "name"=> "scheduledtiming-bounds-end",
                                                             "type"=> "date",
                                                             "documentation"=> "The period end of the prescription timing schedule. This parameter value should be prefixed by &lt;="
                                                         }, {
                                                             "name"=> "_count",
                                                             "type"=> "number",
                                                             "documentation"=> "The maximum number of results to return"
                                                         }]
                                    }, {
                                        "type"=> "Observation",
                                        "interaction"=> [{
                                                             "code"=> "search-type"
                                                         }],
                                        "searchParam"=> [{
                                                             "name"=> "patient",
                                                             "type"=> "reference",
                                                             "documentation"=> "The subject that the observation is about (if patient)"
                                                         }, {
                                                             "name"=> "subject",
                                                             "type"=> "reference",
                                                             "documentation"=> "The subject that the observation is about"
                                                         }, {
                                                             "name"=> "code",
                                                             "type"=> "token",
                                                             "documentation"=> "The type of observation"
                                                         }, {
                                                             "name"=> "date",
                                                             "type"=> "date",
                                                             "documentation"=> "The date range into which the observation falls. This parameter value should be present twice, prefixed once by '>' representing the earliest date and once by '&lt;' representing the latest date."
                                                         }]
                                    }, {
                                        "type"=> "Patient",
                                        "interaction"=> [{
                                                             "code"=> "read"
                                                         }, {
                                                             "code"=> "search-type"
                                                         }],
                                        "readHistory"=> false,
                                        "searchParam"=> [{
                                                             "name"=> "_id",
                                                             "type"=> "token",
                                                             "documentation"=> "The logical resource id associated with the resource (must be supported by all servers)"
                                                         }, {
                                                             "name"=> "birthdate",
                                                             "type"=> "date",
                                                             "documentation"=> "The patient's date of birth"
                                                         }, {
                                                             "name"=> "identifier",
                                                             "type"=> "token",
                                                             "documentation"=> "A patient identifier"
                                                         }, {
                                                             "name"=> "name",
                                                             "type"=> "string",
                                                             "documentation"=> "A portion of either family or given name of the patient"
                                                         }, {
                                                             "name"=> "telecom",
                                                             "type"=> "string",
                                                             "documentation"=> "The value in any kind of telecom details of the patient"
                                                         }, {
                                                             "name"=> "start",
                                                             "type"=> "number",
                                                             "documentation"=> "The offset to use when returning results"
                                                         }, {
                                                             "name"=> "_count",
                                                             "type"=> "number",
                                                             "documentation"=> "The maximum number of results to return"
                                                         }]
                                    }]
                  }]
    }

    MAY2015_CONDITION_BUNDLE ||= {
        "resourceType"=> "Bundle",
        "id"=> "d457d75f-4d8d-439e-9aca-2d8294457652",
        "type"=> "searchset",
        "base"=> "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f",
        "total" => 5,
        "link" => [{
                       "relation"=> "self",
                       "url"=> "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Condition?patient=1316024"
                   }],
        "entry" => [{
                        "resource" => {
                            "resourceType"=> "Condition",
                            "id"=> "d21591516",
                            "meta" => {
                                "versionId"=> "21591516",
                                "lastUpdated"=> "2013-02-08T18:03:09.000Z"
                            },
                            "text" => {
                                "status"=> "generated",
                                "div"=> "&lt;div>&lt;p>&lt;b>Condition&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: Song, River&lt;/p>&lt;p>&lt;b>Category&lt;/b>: Diagnosis&lt;/p>&lt;p>&lt;b>Code&lt;/b>: Absence seizures, 345.0&lt;/p>&lt;p>&lt;b>Clinical Status&lt;/b>: Confirmed&lt;/p>&lt;p>&lt;b>Severity&lt;/b>: &lt;/p>&lt;p>&lt;b>Onset&lt;/b>: 2009-05-04&lt;/p>&lt;/div>"
                            },
                            "patient" => {
                                "reference"=> "Patient/1316024",
                                "display"=> "Song, River"
                            },
                            "encounter" => {
                                "reference"=> "Encounter/1309918"
                            },
                            "asserter" => {
                                "reference"=> "Practitioner/1418008",
                                "display"=> "Howser, Doogie"
                            },
                            "dateAsserted"=> "2013-02-08",
                            "code" => {
                                "coding" => [{
                                                 "system"=> "http://hl7.org/fhir/sid/icd-9",
                                                 "code"=> "345.0",
                                                 "display"=> "Generalized nonconvulsive epilepsy",
                                                 "primary" => true
                                             }],
                                "text"=> "Absence seizures"
                            },
                            "category" => {
                                "coding" => [{
                                                 "system"=> "http://hl7.org/fhir/condition-category",
                                                 "code"=> "diagnosis",
                                                 "display"=> "Diagnosis"
                                             }],
                                "text"=> "Diagnosis"
                            },
                            "clinicalStatus"=> "confirmed",
                            "onsetDateTime"=> "2009-05-04"
                        }
                    }, {
                        "resource" => {
                            "resourceType"=> "Condition",
                            "id"=> "p1147855",
                            "meta" => {
                                "versionId"=> "1209866",
                                "lastUpdated"=> "2013-04-26T14:45:17.000Z"
                            },
                            "text"=> {
                                "status"=> "generated",
                                "div"=> "&lt;div>&lt;p>&lt;b>Condition&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: Song, River&lt;/p>&lt;p>&lt;b>Code&lt;/b>: Lumbar, 264082005&lt;/p>&lt;p>&lt;b>Clinical Status&lt;/b>: Entered in Error&lt;/p>&lt;p>&lt;b>Severity&lt;/b>: &lt;/p>&lt;p>&lt;b>Onset&lt;/b>: &lt;/p>&lt;p>&lt;b>Abatement&lt;/b>: false&lt;/p>&lt;/div>"
                            },
                            "patient"=> {
                                "reference"=> "Patient/1316024",
                                "display"=> "Song, River"
                            },
                            "asserter"=> {
                                "reference"=> "Practitioner/605923",
                                "display"=> "Smith, John"
                            },
                            "dateAsserted"=> "2012-08-28",
                            "code"=> {
                                "coding"=> [{
                                                "system"=> "http://snomed.info/sct",
                                                "code"=> "264082005",
                                                "display"=> "Lumbar (qualifier value)",
                                                "primary"=> true
                                            }],
                                "text"=> "Lumbar"
                            },
                            "clinicalStatus"=> "entered-in-error"
                        }
                    }, {
                        "resource"=> {
                            "resourceType"=> "Condition",
                            "id"=> "p1251556",
                            "meta"=> {
                                "versionId"=> "1251556",
                                "lastUpdated"=> "2015-09-30T18:07:26.000Z"
                            },
                            "text"=> {
                                "status"=> "generated",
                                "div"=> "&lt;div>&lt;p>&lt;b>Condition&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: Song, River&lt;/p>&lt;p>&lt;b>Code&lt;/b>: Red eye, 75705005&lt;/p>&lt;p>&lt;b>Clinical Status&lt;/b>: unknown&lt;/p>&lt;p>&lt;b>Severity&lt;/b>: &lt;/p>&lt;p>&lt;b>Onset&lt;/b>: &lt;/p>&lt;p>&lt;b>Abatement&lt;/b>: false&lt;/p>&lt;/div>"
                            },
                            "patient"=> {
                                "reference"=> "Patient/1316024",
                                "display"=> "Song, River"
                            },
                            "code"=> {
                                "coding"=> [{
                                                "system"=> "http://snomed.info/sct",
                                                "code"=> "75705005",
                                                "display"=> "Red eye (disorder)",
                                                "primary"=> true
                                            }],
                                "text"=> "Red eye"
                            },
                            "clinicalStatus"=> "unknown"
                        }
                    }, {
                        "resource"=> {
                            "resourceType"=> "Condition",
                            "id"=> "p1242256",
                            "meta"=> {
                                "versionId"=> "1242256",
                                "lastUpdated"=> "2014-08-07T20:48:06.000Z"
                            },
                            "text"=> {
                                "status"=> "generated",
                                "div"=> "&lt;div>&lt;p>&lt;b>Condition&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: Song, River&lt;/p>&lt;p>&lt;b>Code&lt;/b>: Heartwater, 73896008&lt;/p>&lt;p>&lt;b>Clinical Status&lt;/b>: unknown&lt;/p>&lt;p>&lt;b>Severity&lt;/b>: &lt;/p>&lt;p>&lt;b>Onset&lt;/b>: 2008&lt;/p>&lt;p>&lt;b>Abatement&lt;/b>: 2014-08-07&lt;/p>&lt;/div>"
                            },
                            "patient"=> {
                                "reference"=> "Patient/1316024",
                                "display"=> "Song, River"
                            },
                            "code"=> {
                                "coding"=> [{
                                                "system"=> "http://snomed.info/sct",
                                                "code"=> "73896008",
                                                "display"=> "Heartwater (disorder)",
                                                "primary"=> true
                                            }],
                                "text"=> "Heartwater"
                            },
                            "clinicalStatus"=> "unknown",
                            "onsetDateTime"=> "2008",
                            "abatementDate"=> "2014-08-07"
                        }
                    }, {
                        "resource"=> {
                            "resourceType"=> "Condition",
                            "id"=> "d21786652",
                            "meta"=> {
                                "versionId"=> "21786656",
                                "lastUpdated"=> "2013-11-21T19:41:14.000Z"
                            },
                            "text"=> {
                                "status"=> "generated",
                                "div"=> "&lt;div>&lt;p>&lt;b>Condition&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: Song, River&lt;/p>&lt;p>&lt;b>Category&lt;/b>: Diagnosis&lt;/p>&lt;p>&lt;b>Code&lt;/b>: Strep throat, 43878008&lt;/p>&lt;p>&lt;b>Clinical Status&lt;/b>: Confirmed&lt;/p>&lt;p>&lt;b>Severity&lt;/b>: &lt;/p>&lt;p>&lt;b>Onset&lt;/b>: 2013-11-21&lt;/p>&lt;/div>"
                            },
                            "patient"=> {
                                "reference"=> "Patient/1316024",
                                "display"=> "Song, River"
                            },
                            "encounter"=> {
                                "reference"=> "Encounter/1591906"
                            },
                            "asserter"=> {
                                "reference"=> "Practitioner/1348007",
                                "display"=> "Who, Doctor"
                            },
                            "dateAsserted"=> "2013-11-21",
                            "code"=> {
                                "coding"=> [{
                                                "system"=> "http://snomed.info/sct",
                                                "code"=> "43878008",
                                                "display"=> "Streptococcal sore throat (disorder)",
                                                "primary"=> true
                                            }],
                                "text"=> "Strep throat"
                            },
                            "category"=> {
                                "coding"=> [{
                                                "system"=> "http://hl7.org/fhir/condition-category",
                                                "code"=> "diagnosis",
                                                "display"=> "Diagnosis"
                                            }],
                                "text"=> "Diagnosis"
                            },
                            "clinicalStatus"=> "confirmed",
                            "onsetDateTime"=> "2013-11-21",
                            "notes"=> "11/21/13 1:41 PM - Who, Doctor\r\nTest #2\r\n\r\n11/21/13 1:40 PM - Who, Doctor\r\nTest"
                        }
                    }]
         }

    MAY2015_DIAGNOSTIC_REPORT_BUNDLE ||= {
        "resourceType" => "Bundle",
        "id" => "c7d2abdd-0c20-433e-a9a9-53e655f79885",
        "type" => "searchset",
        "base" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f",
        "total" => 3,
        "link" => [
            {
                "relation" => "self",
                "url" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/DiagnosticReport?patient=1316020"
            }
        ],
        "entry" => [
            {
                "resource" => {
                    "resourceType" => "DiagnosticReport",
                    "id" => "5153487",
                    "meta" => {
                        "versionId" => "3"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Diagnostic Report&lt;/b>&lt;/p>&lt;p>&lt;b>Service Category&lt;/b>: Radiology&lt;/p>&lt;p>&lt;b>Name&lt;/b>: XR Wrist Complete Left&lt;/p>&lt;p>&lt;b>Performer&lt;/b>: Who, Doctor&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Final&lt;/p>&lt;/div>"
                    },
                    "name" => {
                        "coding" => [
                            {
                                "system" => "http://snomed.info/sct",
                                "code" => "169074008"
                            }
                        ],
                        "text" => "XR Wrist Complete Left"
                    },
                    "status" => "final",
                    "issued" => "2015-08-06T20:03:21.000Z",
                    "subject" => {
                        "reference" => "Patient/1316020"
                    },
                    "performer" => {
                        "reference" => "Practitioner/2048007",
                        "display" => "Who, Doctor"
                    },
                    "encounter" => {
                        "reference" => "Encounter/2787906"
                    },
                    "serviceCategory" => {
                        "coding" => [
                            {
                                "system" => "http://hl7.org/fhir/v2/0074",
                                "code" => "RAD",
                                "display" => "Radiology"
                            }
                        ],
                        "text" => "Radiology"
                    },
                    "diagnosticDateTime" => "2015-08-06T20:03:09.000Z",
                    "conclusion" => "Report   Signature Line:***** Preliminary Report *****   Transcribed by: DW      Reason for exam:4061979"
                }
            },{
                "resource" => {
                    "resourceType" => "DiagnosticReport",
                    "id" => "3153886",
                    "meta" => {
                        "versionId" => "6"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Diagnostic Report&lt;/b>&lt;/p>&lt;p>&lt;b>Service Category&lt;/b>: Radiology&lt;/p>&lt;p>&lt;b>Name&lt;/b>: XR Abdomen Series w/ Chest 1 View | XR Abdomen AP&lt;/p>&lt;p>&lt;b>Performer&lt;/b>: Song, River&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Final&lt;/p>&lt;/div>"
                    },
                    "name" => {
                        "coding" => [
                            {
                                "system" => "http://snomed.info/sct",
                                "code" => "169074008"
                            }
                        ],
                        "text" => "XR Abdomen Series w/ Chest 1 View | XR Abdomen AP"
                    },
                    "status" => "final",
                    "issued" => "2014-04-07T22:19:18.000Z",
                    "subject" => {
                        "reference" => "Patient/1316020"
                    },
                    "performer" => {
                        "reference" => "Practitioner/1666007",
                        "display" => "Song, River"
                    },
                    "encounter" => {
                        "reference" => "Encounter/1309912"
                    },
                    "serviceCategory" => {
                        "coding" => [
                            {
                                "system" => "http://hl7.org/fhir/v2/0074",
                                "code" => "RAD",
                                "display" => "Radiology"
                            }
                        ],
                        "text" => "Radiology"
                    },
                    "diagnosticDateTime" => "2014-02-03T20:31:32.000Z",
                    "conclusion" => "AddendumAddendum   Signature Line:***** Final *****    Signed (Electronic Signature):  04/07/2014 5:19 pm Signed by:  Song, River     ReportGas pattern is unremarkable.  No free air is seen.  There is no hepatosplenomegaly.     IMPRESSION: No acute findings.   Signature Line:***** Final *****    Signed (Electronic Signature):  02/03/2014 2:31 pm Signed by:  Song, River"
                }
            },{
                "resource" => {
                    "resourceType" => "DiagnosticReport",
                    "id" => "4141333",
                    "meta" => {
                        "versionId" => "2"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Diagnostic Report&lt;/b>&lt;/p>&lt;p>&lt;b>Service Category&lt;/b>: Radiology&lt;/p>&lt;p>&lt;b>Name&lt;/b>: CT Abdomen w/ Contrast | CT Cardiac w/Contrast&lt;/p>&lt;p>&lt;b>Performer&lt;/b>: Who, Doctor&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Final&lt;/p>&lt;/div>"
                    },
                    "name" => {
                        "coding" => [
                            {
                                "system" => "http://loinc.org/",
                                "code" => "41806-1"
                            },
                            {
                                "system" => "http://loinc.org/",
                                "code" => "42136-2"
                            },
                            {
                                "system" => "http://snomed.info/sct",
                                "code" => "77477000"
                            }
                        ],
                        "text" => "CT Abdomen w/ Contrast | CT Cardiac w/Contrast"
                    },
                    "status" => "final",
                    "issued" => "2014-12-08T18:23:05.000Z",
                    "subject" => {
                        "reference" => "Patient/1316020"
                    },
                    "performer" => {
                        "reference" => "Practitioner/1628008",
                        "display" => "Who, Doctor"
                    },
                    "encounter" => {
                        "reference" => "Encounter/2571909"
                    },
                    "serviceCategory" => {
                        "coding" => [
                            {
                                "system" => "http://hl7.org/fhir/v2/0074",
                                "code" => "RAD",
                                "display" => "Radiology"
                            }
                        ],
                        "text" => "Radiology"
                    },
                    "diagnosticDateTime" => "2014-12-08T18:19:51.000Z",
                    "conclusion" => "Reporttesting in non-prod   Signature Line:***** Preliminary Report *****   Transcribed by: DW"
                }
            }
        ]
    }

    MAY2015_ENCOUNTER ||= {
        "resourceType" => "Encounter",
        "id" => "3261906",
        "text" => {
            "status" => "generated",
            "div" => "&lt;div>&lt;p>&lt;b>Encounter&lt;/b>&lt;/p>&lt;p>&lt;b>Location&lt;/b>: Outpatient Ctr&lt;/p>&lt;p>&lt;b>Type&lt;/b>: outpatient&lt;/p>&lt;p>&lt;b>Status&lt;/b>: in-progress&lt;/p>&lt;p>&lt;b>Period Start Date&lt;/b>: 2015-08-06T13:00:00.000Z&lt;/p>&lt;p>&lt;b>Reason For Visit&lt;/b>: Checkup&lt;/p>&lt;p>&lt;b>Attending Physician&lt;/b>: Howser, Doogie&lt;/p>&lt;/div>"
        },
        "identifier" => [
            {
                "use" => "usual",
                "system" => "http://cerner.com/fhir/identifier/FINNBR",
                "value" => "20001427"
            }
        ],
        "status" => "in-progress",
        "class" => "outpatient",
        "patient" => {
            "reference" => "Patient/1316020"
        },
        "participant" => [
            {
                "type" => [
                    {
                        "coding" => [
                            {
                                "system" => "http://hl7.org/fhir/v3/ParticipationType",
                                "code" => "ATND",
                                "display" => "attender"
                            }
                        ],
                        "text" => "attender"
                    }
                ],
                "individual" => {
                    "reference" => "Practitioner/2386008",
                    "display" => "Howser, Doogie"
                }
            }
        ],
        "period" => {
            "start" => "2015-08-06T13:00:00.000Z"
        },
        "reason" => [
            {
                "text" => "Checkup"
            }
        ],
        "location" => [
            {
                "location" => {
                    "display" => "Outpatient Ctr"
                }
            }
        ]
    }

    MAY2015_ENCOUNTER_BUNDLE ||= {
        "resourceType" => "Bundle",
        "id" => "2cd77130-032f-4354-921e-d05141ca2184",
        "type" => "searchset",
        "base" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f",
        "total" => 2,
        "link" => [
            {
                "relation" => "self",
                "url" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Encounter?_id=3261906%2C2787906"
            }
        ],
        "entry" => [
            {
                "resource" => {
                    "resourceType" => "Encounter",
                    "id" => "3261906",
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Encounter&lt;/b>&lt;/p>&lt;p>&lt;b>Location&lt;/b>: Outpatient Ctr&lt;/p>&lt;p>&lt;b>Type&lt;/b>: outpatient&lt;/p>&lt;p>&lt;b>Status&lt;/b>: in-progress&lt;/p>&lt;p>&lt;b>Period Start Date&lt;/b>: 2015-08-06T13:00:00.000Z&lt;/p>&lt;p>&lt;b>Reason For Visit&lt;/b>: Checkup&lt;/p>&lt;p>&lt;b>Attending Physician&lt;/b>: Howser, Doogie&lt;/p>&lt;/div>"
                    },
                    "identifier" => [
                        {
                            "use" => "usual",
                            "system" => "http://cerner.com/fhir/identifier/FINNBR",
                            "value" => "20001427"
                        }
                    ],
                    "status" => "in-progress",
                    "class" => "outpatient",
                    "patient" => {
                        "reference" => "Patient/1316020"
                    },
                    "participant" => [
                        {
                            "type" => [
                                {
                                    "coding" => [
                                        {
                                            "system" => "http://hl7.org/fhir/v3/ParticipationType",
                                            "code" => "ATND",
                                            "display" => "attender"
                                        }
                                    ],
                                    "text" => "attender"
                                }
                            ],
                            "individual" => {
                                "reference" => "Practitioner/2386008",
                                "display" => "Howser, Doogie"
                            }
                        }
                    ],
                    "period" => {
                        "start" => "2015-08-06T13:00:00.000Z"
                    },
                    "reason" => [
                        {
                            "text" => "Checkup"
                        }
                    ],
                    "location" => [
                        {
                            "location" => {
                                "display" => "Outpatient Ctr"
                            }
                        }
                    ]
                }
            },
            {
                "resource" => {
                    "resourceType" => "Encounter",
                    "id" => "2787906",
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Encounter&lt;/b>&lt;/p>&lt;p>&lt;b>Location&lt;/b>: Baseline East&lt;/p>&lt;p>&lt;b>Status&lt;/b>: in-progress&lt;/p>&lt;p>&lt;b>Period Start Date&lt;/b>: 2015-01-05T22:50:48.000Z&lt;/p>&lt;p>&lt;b>Reason For Visit&lt;/b>: pain&lt;/p>&lt;p>&lt;b>Attending Physician&lt;/b>: Who, Doctor&lt;/p>&lt;/div>"
                    },
                    "status" => "in-progress",
                    "patient" => {
                        "reference" => "Patient/1316020"
                    },
                    "participant" => [
                        {
                            "type" => [
                                {
                                    "coding" => [
                                        {
                                            "system" => "http://hl7.org/fhir/v3/ParticipationType",
                                            "code" => "ATND",
                                            "display" => "attender"
                                        }
                                    ],
                                    "text" => "attender"
                                }
                            ],
                            "individual" => {
                                "reference" => "Practitioner/1746007",
                                "display" => "Who, Doctor"
                            }
                        }
                    ],
                    "period" => {
                        "start" => "2015-01-05T22:50:48.000Z"
                    },
                    "reason" => [
                        {
                            "text" => "pain"
                        }
                    ],
                    "location" => [
                        {
                            "location" => {
                                "display" => "Baseline East"
                            }
                        }
                    ]
                }
            }
        ]
    }

    MAY2015_PATIENT ||= {
      "resourceType"=> "Patient",
      "id"=> "725944",
      "identifier"=> [{"use"=> "usual",
                      "type"=> {"coding"=> [{"system"=> "http://hl7.org/fhir/v2/0203",
                                           "code"=> "MR",
                                           "display"=> "Medical record number"}]},
                      "system"=> "http://cerner.com/fhir/identifier/MRN",
                      "value"=> "10000086"},
                     {"use"=> "usual",
                      "type"=> {"coding"=> [{"system"=> "http://hl7.org/fhir/v2/0203",
                                           "code"=> "MR",
                                           "display"=> "Medical record number"}]},
                      "system"=> "http://cerner.com/fhir/identifier/MRN",
                      "value"=> "10000057"}],
      "name"=> [{"use"=> "usual",
                "text"=> "SMITH, MORGAN",
                "family"=> ["SMITH"],
                "given"=> ["MORGAN"]}],
      "telecom"=> [{"system"=> "phone",
                   "value"=> "(816) 867-5234",
                   "use"=> "home"}],
      "gender"=> "female",
      "birthDate"=> "1970-01-01",
      "deceasedBoolean"=> false,
      "address"=> [{"use"=> "home",
                   "text"=> "123 Sesame Street\nKansas City, MO 64112\nUSA",
                   "line"=> ["123 Sesame Street"],
                   "city"=> "Kansas City",
                   "state"=> "MO",
                   "postalCode"=> "64112"}],
      "maritalStatus"=> {"coding"=> [{"system"=> "http://hl7.org/fhir/v3/MaritalStatus",
                                    "code"=> "M",
                                    "display"=> "Married"}],
                        "text"=> "Married"},
      "active"=> true
    }

    MAY2015_PATIENT_BUNDLE ||={
      "resourceType"=> "Bundle",
      "id"=> "60eb43c1-1258-4d30-9d9e-ed0b9e2cc33b",
      "type"=> "searchset",
      "base"=> "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f",
      "total"=> 2,
      "link"=> [{"relation"=> "self",
                "url"=> "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Patient?name=Smith&start=0&_count=20"}],
      "entry"=> [{"resource"=> MAY2015_PATIENT},
                {"resource"=> {"resourceType"=> "Patient",
                              "id"=> "685924",
                              "identifier"=> [{"use"=> "usual",
                                              "type"=> {
                                              "coding"=> [{"system"=> "http://hl7.org/fhir/v2/0203",
                                                          "code"=> "MR",
                                                          "display"=> "Medical record number"}]},
                                              "system"=> "http://cerner.com/fhir/identifier/MRN",
                                              "value"=> "00000227"},
                                             {"use"=> "usual",
                                              "type"=> {"coding"=> [{"system"=> "http://hl7.org/fhir/v2/0203",
                                                                   "code"=> "MR",
                                                                   "display"=> "Medical record number"}]},
                                              "system"=> "http://cerner.com/fhir/identifier/MRN",
                                              "value"=> "10000210"}],
                              "name"=> [{"use"=> "usual",
                                        "text"=> "SMITH, JOHN ANDREW",
                                        "family"=> ["SMITH"],
                                        "given"=> ["JOHN", "ANDREW"]}],
                              "gender"=> "male",
                              "birthDate"=> "1976-08-10",
                              "deceasedBoolean"=> false,
                              "careProvider"=> [{"reference"=> "Practitioner/1448009",
                                                "display"=> "Daniel,, Christina"}],
                              "active"=> true}}]
    }

    MAY2015_ALLERGY_INTOLERANCE_BUNDLE ||= {
        "resourceType"=> "Bundle",
        "id"=> "5ab17194-bb85-45fe-94d5-a02a2e8699ab",
        "type"=> "searchset",
        "base"=> "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f",
        "total"=> 2,
        "link"=> [{
                      "relation"=> "self",
                      "url"=> "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/AllergyIntolerance?patient=2744010"
                  }],
        "entry"=> [{
                       "resource"=> {
                           "resourceType"=> "AllergyIntolerance",
                           "id"=> "3643731",
                           "meta"=> {
                               "versionId"=> "3643735",
                               "lastUpdated"=> "2015-03-11T20:34:59.000Z"
                           },
                           "text"=> {
                               "status"=> "generated",
                               "div"=> "&lt;div>&lt;p>&lt;b>Allergy Intolerance&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: RHEUM, TEST ONE&lt;/p>&lt;p>&lt;b>Allergy&lt;/b>: Penicillin&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Refuted&lt;/p>&lt;p>&lt;b>Criticality&lt;/b>: &lt;/p>&lt;p>&lt;b>Category&lt;/b>: Medication&lt;/p>&lt;p>&lt;b>Reactions&lt;/b>: &lt;/p>&lt;p>&lt;b>Onset&lt;/b>: &lt;/p>&lt;p>&lt;b>Comment&lt;/b>: &lt;/p>&lt;/div>"
                           },
                           "recordedDate"=> "2015-03-11T15:34:59.000",
                           "recorder"=> {
                               "reference"=> "Practitioner/3270007",
                               "display"=> "Who, Doctor"
                           },
                           "patient"=> {
                               "reference"=> "Patient/2744010",
                               "display"=> "RHEUM, TEST ONE"
                           },
                           "substance"=> {
                               "coding"=> [{
                                               "system"=> "http://snomed.info/sct",
                                               "code"=> "373270004",
                                               "display"=> "Penicillin -class of antibiotic- (substance)",
                                               "primary"=> true
                                           }],
                               "text"=> "Penicillin"
                           },
                           "status"=> "refuted",
                           "type"=> "immune",
                           "category"=> "medication"
                       }
                   }, {
                       "resource"=> {
                           "resourceType"=> "AllergyIntolerance",
                           "id"=> "3643739",
                           "meta"=> {
                               "versionId"=> "3643739",
                               "lastUpdated"=> "2015-03-11T20:36:08.000Z"
                           },
                           "text"=> {
                               "status"=> "generated",
                               "div"=> "&lt;div>&lt;p>&lt;b>Allergy Intolerance&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: RHEUM, TEST ONE&lt;/p>&lt;p>&lt;b>Allergy&lt;/b>: Dust allergy&lt;/p>&lt;p>&lt;b>Status&lt;/b>: &lt;/p>&lt;p>&lt;b>Criticality&lt;/b>: &lt;/p>&lt;p>&lt;b>Category&lt;/b>: Environment&lt;/p>&lt;p>&lt;b>Reactions&lt;/b>: &lt;/p>&lt;p>&lt;b>Onset&lt;/b>: &lt;/p>&lt;p>&lt;b>Comment&lt;/b>: &lt;/p>&lt;/div>"
                           },
                           "recordedDate"=> "2015-03-11T15:36:08.000",
                           "recorder"=> {
                               "reference"=> "Practitioner/3270007",
                               "display"=> "Who, Doctor"
                           },
                           "patient"=> {
                               "reference"=> "Patient/2744010",
                               "display"=> "RHEUM, TEST ONE"
                           },
                           "substance"=> {
                               "coding"=> [{
                                               "system"=> "http://snomed.info/sct",
                                               "code"=> "390952000",
                                               "display"=> "Dust allergy (disorder)",
                                               "primary"=> true
                                           }],
                               "text"=> "Dust allergy"
                           },
                           "type"=> "immune",
                           "category"=> "environment"
                       }
                   }]
    }

    MAY2015_IMMUNIZATION_BUNDLE ||= {
        "resourceType" => "Bundle",
        "id" => "6236583e-e881-4bce-9964-decd5457b02f",
        "type" => "searchset",
        "base" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f",
        "total" => 6,
        "link" => [
            {
                "relation" => "self",
                "url" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Immunization?patient=1083999"
            }
        ],
        "entry" => [
            {
                "resource" => {
                    "resourceType" => "Immunization",
                    "id" => "M2247765",
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Immunization&lt;/b>&lt;/p>&lt;p>&lt;b>Date&lt;/b>: 2011-11-29&lt;/p>&lt;p>&lt;b>Given&lt;/b>: Yes&lt;/p>&lt;p>&lt;b>Administered by&lt;/b>: Physician, One&lt;/p>&lt;/div>"
                    },
                    "date" => "2011-11-29",
                    "vaccineType" => {
                        "coding" => [
                            {
                                "system" => "http://hl7.org/fhir/v3/VaccineType",
                                "code" => "43"
                            }
                        ]
                    },
                    "patient" => {
                        "reference" => "Patient/1083999"
                    },
                    "wasNotGiven" => false,
                    "reported" => true,
                    "performer" => {
                        "reference" => "Practitioner/1262007",
                        "display" => "Physician, One"
                    },
                    "encounter" => {
                        "reference" => "Encounter/1135920"
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "Immunization",
                    "id" => "M2247761",
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Immunization&lt;/b>&lt;/p>&lt;p>&lt;b>Date&lt;/b>: 2011-11-29&lt;/p>&lt;p>&lt;b>Given&lt;/b>: Yes&lt;/p>&lt;p>&lt;b>Administered by&lt;/b>: Physician, One&lt;/p>&lt;/div>"
                    },
                    "date" => "2011-11-29",
                    "vaccineType" => {
                        "coding" => [
                            {
                                "system" => "http://hl7.org/fhir/v3/VaccineType",
                                "code" => "43"
                            }
                        ],
                        "text" => "hepatitis B vaccine pediatric 10 mcg/0.5 mL intramuscular suspension (obsolete)"
                    },
                    "patient" => {
                        "reference" => "Patient/1083999"
                    },
                    "wasNotGiven" => false,
                    "reported" => true,
                    "performer" => {
                        "reference" => "Practitioner/1262007",
                        "display" => "Physician, One"
                    },
                    "encounter" => {
                        "reference" => "Encounter/1135920"
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "Immunization",
                    "id" => "M2247769",
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Immunization&lt;/b>&lt;/p>&lt;p>&lt;b>Date&lt;/b>: 2011-11-29&lt;/p>&lt;p>&lt;b>Given&lt;/b>: Yes&lt;/p>&lt;p>&lt;b>Administered by&lt;/b>: Physician, One&lt;/p>&lt;/div>"
                    },
                    "date" => "2011-11-29",
                    "vaccineType" => {
                        "coding" => [
                            {
                                "system" => "http://hl7.org/fhir/v3/VaccineType",
                                "code" => "43"
                            }
                        ]
                    },
                    "patient" => {
                        "reference" => "Patient/1083999"
                    },
                    "wasNotGiven" => false,
                    "reported" => true,
                    "performer" => {
                        "reference" => "Practitioner/1262007",
                        "display" => "Physician, One"
                    },
                    "encounter" => {
                        "reference" => "Encounter/1135920"
                    },
                    "manufacturer" => {
                        "reference" => "Organization/4296975",
                        "display" => "Able Laboratories Inc"
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "Immunization",
                    "id" => "M2247752",
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Immunization&lt;/b>&lt;/p>&lt;p>&lt;b>Date&lt;/b>: 2012-03-16T09:43:00.000Z&lt;/p>&lt;p>&lt;b>Given&lt;/b>: Yes&lt;/p>&lt;p>&lt;b>Administered by&lt;/b>: Physician, One&lt;/p>&lt;p>&lt;b>Site&lt;/b>: left arm&lt;/p>&lt;p>&lt;b>Route&lt;/b>: ID&lt;/p>&lt;/div>"
                    },
                    "date" => "2012-03-16T09:43:00.000Z",
                    "vaccineType" => {
                        "coding" => [
                            {
                                "system" => "http://hl7.org/fhir/v3/VaccineType",
                                "code" => "83"
                            }
                        ],
                        "text" => "hepatitis A pediatric vaccine"
                    },
                    "patient" => {
                        "reference" => "Patient/1083999"
                    },
                    "wasNotGiven" => false,
                    "reported" => false,
                    "performer" => {
                        "reference" => "Practitioner/1262007",
                        "display" => "Physician, One"
                    },
                    "encounter" => {
                        "reference" => "Encounter/1135920"
                    },
                    "manufacturer" => {
                        "reference" => "Organization/4297457",
                        "display" => "A-A Spectrum Healthcare Products"
                    },
                    "lotNumber" => "11",
                    "expirationDate" => "2013-03-25",
                    "site" => {
                        "coding" => [
                            {
                                "system" => "http://hl7.org/fhir/v3/ActSite",
                                "code" => "LA",
                                "display" => "left arm"
                            }
                        ],
                        "text" => "left arm"
                    },
                    "route" => {
                        "text" => "ID"
                    },
                    "doseQuantity" => {
                        "value" => 1.0,
                        "units" => "mL"
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "Immunization",
                    "id" => "HM1110832",
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Immunization&lt;/b>&lt;/p>&lt;p>&lt;b>Vaccine Type&lt;/b>: CERNER_CDC_IPV&lt;/p>&lt;p>&lt;b>Date Attempted&lt;/b>: 2011-05-17&lt;/p>&lt;p>&lt;b>Given&lt;/b>: No&lt;/p>&lt;p>&lt;b>Administered by&lt;/b>: Who, Doctor&lt;/p>&lt;/div>"
                    },
                    "date" => "2011-05-17",
                    "vaccineType" => {
                        "text" => "CERNER_CDC_IPV"
                    },
                    "patient" => {
                        "reference" => "Patient/1083999"
                    },
                    "wasNotGiven" => true,
                    "reported" => false,
                    "performer" => {
                        "reference" => "Practitioner/1",
                        "display" => "Who, Doctor"
                    },
                    "location" => {
                        "reference" => "Organization/589723"
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "Immunization",
                    "id" => "HM1110830",
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Immunization&lt;/b>&lt;/p>&lt;p>&lt;b>Vaccine Type&lt;/b>: CERNER_CDC_INFLUENZA_CHILD&lt;/p>&lt;p>&lt;b>Given&lt;/b>: No&lt;/p>&lt;p>&lt;b>Administered by&lt;/b>: Who, Doctor&lt;/p>&lt;p>&lt;b>Reason Not Given&lt;/b>: patient objection&lt;/p>&lt;/div>"
                    },
                    "vaccineType" => {
                        "text" => "CERNER_CDC_INFLUENZA_CHILD"
                    },
                    "patient" => {
                        "reference" => "Patient/1083999"
                    },
                    "wasNotGiven" => true,
                    "reported" => false,
                    "performer" => {
                        "reference" => "Practitioner/1",
                        "display" => "Who, Doctor"
                    },
                    "location" => {
                        "reference" => "Organization/589723"
                    },
                    "explanation" => {
                        "reasonNotGiven" => [
                            {
                                "coding" => [
                                    {
                                        "system" => "http://hl7.org/fhir/v3/ActReason",
                                        "code" => "PATOBJ",
                                        "display" => "patient objection"
                                    }
                                ],
                                "text" => "patient objection"
                            }
                        ]
                    }
                }
            }
        ]
    }
    
    MAY2015_MEDICATION_PRESCRIPTION_ACTIVE_BUNDLE ||= {
        "resourceType" => "Bundle",
        "id" => "06d99b3a-ee60-493a-a700-b23cec4dfcf1",
        "type" => "searchset",
        "base" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f",
        "total" => 7,
        "link" => [
            {
                "relation" => "self",
                "url" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/MedicationPrescription?patient=2744010&status=active%2Cdraft"
            }
        ],
        "entry" => [
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "16566157",
                    "meta" => {
                        "versionId" => "0"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: Procardia XL 30 mg oral tablet, extended release&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 30 mg, 1 tab(s), Oral, Daily, 30 tab(s)&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Active&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "2765117",
                            "code" => {
                                "coding" => [
                                    {
                                        "system" => "http://www.nlm.nih.gov/research/umls/rxnorm",
                                        "code" => "207772",
                                        "display" => "24 HR Nifedipine 30 MG Extended Release Oral Tablet [Procardia]"
                                    }
                                ],
                                "text" => "Procardia XL 30 mg oral tablet, extended release"
                            },
                            "name" => "Procardia XL 30 mg oral tablet, extended release"
                        }
                    ],
                    "status" => "active",
                    "patient" => {
                        "reference" => "Patient/2744010"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/2692009",
                        "display" => "Song, River"
                    },
                    "medication" => {
                        "reference" => "#2765117",
                        "display" => "Procardia XL 30 mg oral tablet, extended release"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "30 mg, 1 tab(s), Oral, Daily, 30 tab(s)",
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2014-08-14T19:00:00.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "Daily"
                                }
                            },
                            "route" => {
                                "text" => "Oral"
                            },
                            "doseQuantity" => {
                                "value" => 30.0,
                                "units" => "mg"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#2765117",
                            "display" => "Procardia XL 30 mg oral tablet, extended release"
                        },
                        "quantity" => {
                            "value" => "30",
                            "units" => "tab(s)"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "16566159",
                    "meta" => {
                        "versionId" => "0"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: predniSONE 5 mg oral tablet&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 5 mg, 1 tabs, Oral, Daily, tabs, PRN: Instruct&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Active&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "2767469",
                            "code" => {
                                "coding" => [
                                    {
                                        "system" => "http://www.nlm.nih.gov/research/umls/rxnorm",
                                        "code" => "763179",
                                        "display" => "{48 (Prednisone 5 MG Oral Tablet) } Pack"
                                    }
                                ],
                                "text" => "predniSONE 5 mg oral tablet"
                            },
                            "name" => "predniSONE 5 mg oral tablet"
                        }
                    ],
                    "status" => "active",
                    "patient" => {
                        "reference" => "Patient/2744010"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/2692009",
                        "display" => "Song, River"
                    },
                    "medication" => {
                        "reference" => "#2767469",
                        "display" => "predniSONE 5 mg oral tablet"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "5 mg, 1 tabs, Oral, Daily, tabs, PRN: Instruct",
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2014-08-14T19:00:00.000Z",
                                        "end" => "2014-09-14T19:00:00.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "Daily"
                                }
                            },
                            "asNeededCodeableConcept" => {
                                "text" => "Instruct"
                            },
                            "route" => {
                                "text" => "Oral"
                            },
                            "doseQuantity" => {
                                "value" => 5.0,
                                "units" => "mg"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#2767469",
                            "display" => "predniSONE 5 mg oral tablet"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "14203884",
                    "meta" => {
                        "versionId" => "0"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: Aspercreme 10% topical lotion&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 1 boxes, GTUBE, 10x/Day, 2 boxes, 0 Refill(s)&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Active&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "5213029",
                            "code" => {
                                "coding" => [
                                    {
                                        "system" => "http://www.nlm.nih.gov/research/umls/rxnorm",
                                        "code" => "1101829",
                                        "display" => "trolamine salicylate 100 MG/ML Topical Lotion [Aspercreme]"
                                    }
                                ],
                                "text" => "Aspercreme 10% topical lotion"
                            },
                            "name" => "Aspercreme 10% topical lotion"
                        }
                    ],
                    "status" => "active",
                    "patient" => {
                        "reference" => "Patient/2744010"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/1400009",
                        "display" => "Who, Doctor"
                    },
                    "medication" => {
                        "reference" => "#5213029",
                        "display" => "Aspercreme 10% topical lotion"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "1 boxes, GTUBE, 10x/Day, 2 boxes, 0 Refill(s)",
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2015-05-21T20:36:00.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "10x/Day"
                                }
                            },
                            "route" => {
                                "text" => "GTUBE"
                            },
                            "doseQuantity" => {
                                "value" => 1.0,
                                "units" => "boxes"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#5213029",
                            "display" => "Aspercreme 10% topical lotion"
                        },
                        "numberOfRepeatsAllowed" => 0,
                        "quantity" => {
                            "value" => "2",
                            "units" => "boxes"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "17865897",
                    "meta" => {
                        "versionId" => "0"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: albuterol 2 mg oral tablet&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 2 mg, 1 tab(s), Oral, QID, 120 tab(s)&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Active&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "2748635",
                            "code" => {
                                "coding" => [
                                    {
                                        "system" => "http://www.nlm.nih.gov/research/umls/rxnorm",
                                        "code" => "197316",
                                        "display" => "Albuterol 2 MG Oral Tablet"
                                    }
                                ],
                                "text" => "albuterol 2 mg oral tablet"
                            },
                            "name" => "albuterol 2 mg oral tablet"
                        }
                    ],
                    "status" => "active",
                    "patient" => {
                        "reference" => "Patient/2744010"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/3270007",
                        "display" => "Howser, Doogie"
                    },
                    "medication" => {
                        "reference" => "#2748635",
                        "display" => "albuterol 2 mg oral tablet"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "2 mg, 1 tab(s), Oral, QID, 120 tab(s)",
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2015-03-11T20:38:00.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "QID"
                                }
                            },
                            "route" => {
                                "text" => "Oral"
                            },
                            "doseQuantity" => {
                                "value" => 2.0,
                                "units" => "mg"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#2748635",
                            "display" => "albuterol 2 mg oral tablet"
                        },
                        "quantity" => {
                            "value" => "120",
                            "units" => "tab(s)"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "18937899",
                    "meta" => {
                        "versionId" => "0"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: Colace&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 50 mg = 1 caps, Oral, q4hr, order duration: 5 days, first dose dttm: 07/31/15 18:00:00 CDT, stop date 08/05/15 17:59:00 CDT&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Active&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "4318409",
                            "code" => {
                                "text" => "Colace"
                            },
                            "name" => "Colace"
                        }
                    ],
                    "status" => "active",
                    "patient" => {
                        "reference" => "Patient/2744010"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/1616012",
                        "display" => "House, Gregory"
                    },
                    "medication" => {
                        "reference" => "#4318409",
                        "display" => "Colace"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "50 mg = 1 caps, Oral, q4hr, order duration: 5 days, first dose dttm: 07/31/15 18:00:00 CDT, stop date 08/05/15 17:59:00 CDT",
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2015-07-31T23:00:00.000Z",
                                        "end" => "2015-08-05T22:59:00.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "q4hr"
                                }
                            },
                            "route" => {
                                "text" => "Oral"
                            },
                            "doseQuantity" => {
                                "value" => 50.0,
                                "units" => "mg"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#4318409",
                            "display" => "Colace"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "16566161",
                    "meta" => {
                        "versionId" => "0"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: methotrexate 10 mg oral tablet&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 10 mg, 1 tab(s), Oral, qWeek, 1 tabs&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Active&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "2763106",
                            "code" => {
                                "coding" => [
                                    {
                                        "system" => "http://www.nlm.nih.gov/research/umls/rxnorm",
                                        "code" => "105586",
                                        "display" => "Methotrexate 10 MG Oral Tablet"
                                    }
                                ],
                                "text" => "methotrexate 10 mg oral tablet"
                            },
                            "name" => "methotrexate 10 mg oral tablet"
                        }
                    ],
                    "status" => "active",
                    "patient" => {
                        "reference" => "Patient/2744010"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/2692009",
                        "display" => "Song, River"
                    },
                    "medication" => {
                        "reference" => "#2763106",
                        "display" => "methotrexate 10 mg oral tablet"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "10 mg, 1 tab(s), Oral, qWeek, 1 tabs",
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2014-08-14T19:00:00.000Z",
                                        "end" => "2014-09-14T19:00:00.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "qWeek"
                                }
                            },
                            "route" => {
                                "text" => "Oral"
                            },
                            "doseQuantity" => {
                                "value" => 10.0,
                                "units" => "mg"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#2763106",
                            "display" => "methotrexate 10 mg oral tablet"
                        },
                        "quantity" => {
                            "value" => "1",
                            "units" => "tabs"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "16566163",
                    "meta" => {
                        "versionId" => "0"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: Zocor 10 mg oral tablet&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 340 mg, 34 tabs, Oral, Once a day (at bedtime), tabs&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Active&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "2768849",
                            "code" => {
                                "coding" => [
                                    {
                                        "system" => "http://www.nlm.nih.gov/research/umls/rxnorm",
                                        "code" => "104490",
                                        "display" => "Simvastatin 10 MG Oral Tablet [Zocor]"
                                    }
                                ],
                                "text" => "Zocor 10 mg oral tablet"
                            },
                            "name" => "Zocor 10 mg oral tablet"
                        }
                    ],
                    "status" => "active",
                    "patient" => {
                        "reference" => "Patient/2744010"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/2692009",
                        "display" => "Song, River"
                    },
                    "medication" => {
                        "reference" => "#2768849",
                        "display" => "Zocor 10 mg oral tablet"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "340 mg, 34 tabs, Oral, Once a day (at bedtime), tabs",
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2014-08-14T19:00:00.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "Once a day (at bedtime)"
                                }
                            },
                            "route" => {
                                "text" => "Oral"
                            },
                            "doseQuantity" => {
                                "value" => 340.0,
                                "units" => "mg"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#2768849",
                            "display" => "Zocor 10 mg oral tablet"
                        }
                    }
                }
            }
        ]
    }

    MAY2015_MEDICATION_PRESCRIPTION_INACTIVE_BUNDLE ||= {
        "resourceType" => "Bundle",
        "id" => "e8e295fb-9370-40bc-88ba-87d1311ac619",
        "type" => "searchset",
        "base" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f",
        "link" => [
            {
                "relation" => "self",
                "url" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/MedicationPrescription?patient=1316020&status=completed%2Con-hold%2Cstopped&_count=5"
            },
            {
                "relation" => "next",
                "url" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/MedicationPrescription?patient=1316020&status=completed%2Con-hold%2Cstopped&_count=5&scheduledtiming-bounds-end=%3C%3D2015-02-10T16%3A20%3A25.000Z&context=14199276"
            }
        ],
        "entry" => [
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "14192352",
                    "meta" => {
                        "versionId" => "1"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: amoxicillin 500 mg oral tablet&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 10.0 mg, Chewed, 1-3x/Day, Take twice daily with meal, 1.0 bottles, PRN: Instruct, 0 Refill(s)&lt;/p>&lt;p>&lt;b>Status&lt;/b>: stopped&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "22283427",
                            "code" => {
                                "coding" => [
                                    {
                                        "system" => "http://www.nlm.nih.gov/research/umls/rxnorm",
                                        "code" => "308192",
                                        "display" => "Amoxicillin 500 MG Oral Tablet"
                                    }
                                ],
                                "text" => "amoxicillin 500 mg oral tablet"
                            },
                            "name" => "amoxicillin 500 mg oral tablet"
                        }
                    ],
                    "status" => "stopped",
                    "patient" => {
                        "reference" => "Patient/1316020"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/1590015",
                        "display" => "Who, Doctor"
                    },
                    "medication" => {
                        "reference" => "#22283427",
                        "display" => "amoxicillin 500 mg oral tablet"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "10.0 mg, Chewed, 1-3x/Day, Take twice daily with meal, 1.0 bottles, PRN: Instruct, 0 Refill(s)",
                            "additionalInstructions" => {
                                "text" => "Take twice daily with meal"
                            },
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2014-09-17T01:31:00.000Z",
                                        "end" => "2015-06-18T22:38:45.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "1-3x/Day"
                                }
                            },
                            "asNeededCodeableConcept" => {
                                "text" => "Instruct"
                            },
                            "route" => {
                                "text" => "Chewed"
                            },
                            "doseQuantity" => {
                                "value" => 10.0,
                                "units" => "mg"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#22283427",
                            "display" => "amoxicillin 500 mg oral tablet"
                        },
                        "numberOfRepeatsAllowed" => 0,
                        "quantity" => {
                            "value" => 1.0,
                            "units" => "bottles"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "14201768",
                    "meta" => {
                        "versionId" => "3"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: aspirin 325 mg oral tablet&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 1.0 tabs, Oral, Daily, 100.0 tabs, PRN: Instruct, 0 Refill(s)&lt;/p>&lt;p>&lt;b>Status&lt;/b>: completed&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "2750107",
                            "code" => {
                                "coding" => [
                                    {
                                        "system" => "http://www.nlm.nih.gov/research/umls/rxnorm",
                                        "code" => "212033",
                                        "display" => "Aspirin 325 MG Oral Tablet"
                                    }
                                ],
                                "text" => "aspirin 325 mg oral tablet"
                            },
                            "name" => "aspirin 325 mg oral tablet"
                        }
                    ],
                    "status" => "completed",
                    "patient" => {
                        "reference" => "Patient/1316020"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/1314013",
                        "display" => "Song, River"
                    },
                    "medication" => {
                        "reference" => "#2750107",
                        "display" => "aspirin 325 mg oral tablet"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "1.0 tabs, Oral, Daily, 100.0 tabs, PRN: Instruct, 0 Refill(s)",
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2015-04-14T15:45:00.000Z",
                                        "end" => "2015-06-18T22:35:21.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "Daily"
                                }
                            },
                            "asNeededCodeableConcept" => {
                                "text" => "Instruct"
                            },
                            "route" => {
                                "text" => "Oral"
                            },
                            "doseQuantity" => {
                                "value" => 1.0,
                                "units" => "tabs"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#2750107",
                            "display" => "aspirin 325 mg oral tablet"
                        },
                        "numberOfRepeatsAllowed" => 0,
                        "quantity" => {
                            "value" => 100.0,
                            "units" => "tabs"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "14192976",
                    "meta" => {
                        "versionId" => "3"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: Nyquil Liquicap oral capsule&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 1.0 tabs, Oral, 1-2x/Day, 10.0 tabs, 10 Refill(s)&lt;/p>&lt;p>&lt;b>Status&lt;/b>: completed&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "2749728",
                            "code" => {
                                "text" => "Nyquil Liquicap oral capsule"
                            },
                            "name" => "Nyquil Liquicap oral capsule"
                        }
                    ],
                    "status" => "completed",
                    "patient" => {
                        "reference" => "Patient/1316020"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/1590015",
                        "display" => "Who, Doctor"
                    },
                    "medication" => {
                        "reference" => "#2749728",
                        "display" => "Nyquil Liquicap oral capsule"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "1.0 tabs, Oral, 1-2x/Day, 10.0 tabs, 10 Refill(s)",
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2014-09-23T14:50:00.000Z",
                                        "end" => "2015-05-22T00:41:40.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "1-2x/Day"
                                }
                            },
                            "route" => {
                                "text" => "Oral"
                            },
                            "doseQuantity" => {
                                "value" => 1.0,
                                "units" => "tabs"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#2749728",
                            "display" => "Nyquil Liquicap oral capsule"
                        },
                        "numberOfRepeatsAllowed" => 10,
                        "quantity" => {
                            "value" => 10.0,
                            "units" => "tabs"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "14193568",
                    "meta" => {
                        "versionId" => "1"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: acetaZOLAMIDE 125 mg oral tablet&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 1.0 tabs, Oral, Daily, 90.0 tabs, PRN: Instruct, 0 Refill(s)&lt;/p>&lt;p>&lt;b>Status&lt;/b>: stopped&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "2748405",
                            "code" => {
                                "coding" => [
                                    {
                                        "system" => "http://www.nlm.nih.gov/research/umls/rxnorm",
                                        "code" => "18631",
                                        "display" => "Azithromycin"
                                    }
                                ],
                                "text" => "acetaZOLAMIDE 125 mg oral tablet"
                            },
                            "name" => "acetaZOLAMIDE 125 mg oral tablet"
                        }
                    ],
                    "status" => "stopped",
                    "patient" => {
                        "reference" => "Patient/1316020"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/1314015",
                        "display" => "Howser, Doogie"
                    },
                    "medication" => {
                        "reference" => "#2748405",
                        "display" => "acetaZOLAMIDE 125 mg oral tablet"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "1.0 tabs, Oral, Daily, 90.0 tabs, PRN: Instruct, 0 Refill(s)",
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2014-10-07T16:13:00.000Z",
                                        "end" => "2015-03-04T23:36:59.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "Daily"
                                }
                            },
                            "asNeededCodeableConcept" => {
                                "text" => "Instruct"
                            },
                            "route" => {
                                "text" => "Oral"
                            },
                            "doseQuantity" => {
                                "value" => 1.0,
                                "units" => "tabs"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#2748405",
                            "display" => "acetaZOLAMIDE 125 mg oral tablet"
                        },
                        "numberOfRepeatsAllowed" => 0,
                        "quantity" => {
                            "value" => 90.0,
                            "units" => "tabs"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "MedicationPrescription",
                    "id" => "14198144",
                    "meta" => {
                        "versionId" => "1"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>MedicationPrescription&lt;/b>&lt;/p>&lt;p>&lt;b>Medication Name&lt;/b>: acetaminophen 160 mg oral tablet&lt;/p>&lt;p>&lt;b>Dosage Instruction Text&lt;/b>: 1.0 tabs, Buccal, BID, 4.0 tabs, PRN: Instruct, 0 Refill(s)&lt;/p>&lt;p>&lt;b>Status&lt;/b>: stopped&lt;/p>&lt;/div>"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Medication",
                            "id" => "2748051",
                            "code" => {
                                "coding" => [
                                    {
                                        "system" => "http://www.nlm.nih.gov/research/umls/rxnorm",
                                        "code" => "282464",
                                        "display" => "Acetaminophen 160 MG Oral Tablet"
                                    }
                                ],
                                "text" => "acetaminophen 160 mg oral tablet"
                            },
                            "name" => "acetaminophen 160 mg oral tablet"
                        }
                    ],
                    "status" => "stopped",
                    "patient" => {
                        "reference" => "Patient/1316020"
                    },
                    "prescriber" => {
                        "reference" => "Practitioner/1328007",
                        "display" => "House, Gregory"
                    },
                    "medication" => {
                        "reference" => "#2748051",
                        "display" => "acetaminophen 160 mg oral tablet"
                    },
                    "dosageInstruction" => [
                        {
                            "text" => "1.0 tabs, Buccal, BID, 4.0 tabs, PRN: Instruct, 0 Refill(s)",
                            "scheduledTiming" => {
                                "repeat" => {
                                    "bounds" => {
                                        "start" => "2015-01-27T11:45:00.000Z",
                                        "end" => "2015-02-10T16:22:23.000Z"
                                    }
                                },
                                "code" => {
                                    "text" => "BID"
                                }
                            },
                            "asNeededCodeableConcept" => {
                                "text" => "Instruct"
                            },
                            "route" => {
                                "text" => "Buccal"
                            },
                            "doseQuantity" => {
                                "value" => 1.0,
                                "units" => "tabs"
                            }
                        }
                    ],
                    "dispense" => {
                        "medication" => {
                            "reference" => "#2748051",
                            "display" => "acetaminophen 160 mg oral tablet"
                        },
                        "numberOfRepeatsAllowed" => 0,
                        "quantity" => {
                            "value" => 4.0,
                            "units" => "tabs"
                        }
                    }
                }
            }
        ]
    }

    MAY2015_OBSERVATION_BUNDLE ||= {
        "resourceType" => "Bundle",
        "id" => "17207056-05f2-4e07-9770-77cbe0cbc8b0",
        "type" => "searchset",
        "base" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f",
        "link" => [
            {
                "relation" => "self",
                "url" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation?subject%3APatient=2744010&_count=10&date=%3E2014-09-24T12%3A00%3A00.000Z&date=%3C2015-09-24T12%3A00%3A00.000Z"
            },
            {
                "relation" => "next",
                "url" => "https://fhir-open.sandboxcernerpowerchart.com/may2015/d075cf8b-3261-481d-97e5-ba6c48d3b41f/Observation?subject%3APatient=2744010&pageContext=H4sIAAAAAAAAAJ1TbW%2BbMBD%2BK63zlSJDSLvxqYQ4GxJJEJhor0IWOKklsCNjqmZt%2F%2FvOoVVfpEnbENJxvueeO%2B4536OOs37QvOPSbD0Uolp1bs215Nrt%2BtvarVshRc1afgsI9xXaZR37paR7YHsh92508jK257GSht%2BZyfW50QMH8%2FeUtRaGa8HcnBstID4%2FEgsquImfQufXk0HLcOQLO9GEXHfugeteybCXDZf70L8KAuxhgPrYCy7wxws%2FoJ4fYgyvizH%2BNoZmfwidUt9VqZXmrlYtP2i1Ey1%2FrkV%2FDBhPm9RJFuOXB7lyaFsw86hI4iqiNE%2FmJSUFHJHlksQ02ZJqEVECB1GanuWkKFN6VtjIZn2CrTL6tUqTgr53crIkOVnHpMqj9SfiRKecKss322RBciferFZkTZ1tlJaW32oA5p9keKvsXDRC89oIJVlrBS4MM%2FyFek2%2B0Cou82KT27FeYuzPZlMnCD5M%2FSvseIF%2FCdbH9gHAjrW9Tctysk02ZfGS%2BjQ1aPVh8oCRg3pVC9Z%2BFr1R%2Bmi38x7VUHoPXtz0KPz%2B00EHZgT0nDToWXYHscHcKNiXI%2BzzKBOQad4y%2Bw%2F9jThYNOCsnNkoZ5ksAPzfmgP%2FTshmfszGdlBoh%2FPowHUarOfhx999w9l9awMAAA%3D%3D&direction=NEXT"
            }
        ],
        "entry" => [
            {
                "resource" => {
                    "resourceType" => "Observation",
                    "id" => "3025861",
                    "meta" => {
                        "versionId" => "3025861",
                        "lastUpdated" => "2014-09-24T23:18:40.000Z"
                    },
                    "contained" => [
                        {
                            "resourceType" => "Observation",
                            "id" => "3025861-q6930392",
                            "meta" => {
                                "lastUpdated" => "2014-09-24T23:18:40.000Z"
                            },
                            "text" => {
                                "status" => "generated",
                                "div" => "&lt;div>&lt;p>&lt;b>Observation&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: 2744010&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Active&lt;/p>&lt;p>&lt;b>Category&lt;/b>: &lt;/p>&lt;p>&lt;b>Question&lt;/b>: SHX Alcohol use&lt;/p>&lt;p>&lt;b>Response&lt;/b>: Current&lt;/p>&lt;/div>"
                            },
                            "code" => {
                                "text" => "SHX Alcohol use"
                            },
                            "valueString" => "Current",
                            "issued" => "2014-09-24T23:18:40.000Z",
                            "status" => "final",
                            "subject" => {
                                "reference" => "Patient/2744010"
                            }
                        },
                        {
                            "resourceType" => "Observation",
                            "id" => "3025861-q6930388",
                            "meta" => {
                                "lastUpdated" => "2014-09-24T23:18:40.000Z"
                            },
                            "text" => {
                                "status" => "generated",
                                "div" => "&lt;div>&lt;p>&lt;b>Observation&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: 2744010&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Active&lt;/p>&lt;p>&lt;b>Category&lt;/b>: &lt;/p>&lt;p>&lt;b>Question&lt;/b>: SHX Alcohol type&lt;/p>&lt;p>&lt;b>Response&lt;/b>: Wine&lt;/p>&lt;/div>"
                            },
                            "code" => {
                                "text" => "SHX Alcohol type"
                            },
                            "valueString" => "Wine",
                            "issued" => "2014-09-24T23:18:40.000Z",
                            "status" => "final",
                            "subject" => {
                                "reference" => "Patient/2744010"
                            }
                        },
                        {
                            "resourceType" => "Observation",
                            "id" => "3025861-q6930384",
                            "meta" => {
                                "lastUpdated" => "2014-09-24T23:18:40.000Z"
                            },
                            "text" => {
                                "status" => "generated",
                                "div" => "&lt;div>&lt;p>&lt;b>Observation&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: 2744010&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Active&lt;/p>&lt;p>&lt;b>Category&lt;/b>: &lt;/p>&lt;p>&lt;b>Question&lt;/b>: SHX Alcohol frequency&lt;/p>&lt;p>&lt;b>Response&lt;/b>: Daily&lt;/p>&lt;/div>"
                            },
                            "code" => {
                                "text" => "SHX Alcohol frequency"
                            },
                            "valueString" => "Daily",
                            "issued" => "2014-09-24T23:18:40.000Z",
                            "status" => "final",
                            "subject" => {
                                "reference" => "Patient/2744010"
                            }
                        }
                    ],
                    "code" => {
                        "coding" => [
                            {
                                "system" => "http://snomed.info/sct",
                                "code" => "363905002",
                                "display" => "Details of alcohol drinking behavior (observable entity)"
                            }
                        ],
                        "text" => "Alcohol"
                    },
                    "status" => "final",
                    "subject" => {
                        "reference" => "Patient/2744010"
                    },
                    "related" => [
                        {
                            "type" => "has-component",
                            "target" => {
                                "reference" => "#3025861-q6930392"
                            }
                        },
                        {
                            "type" => "has-component",
                            "target" => {
                                "reference" => "#3025861-q6930388"
                            }
                        },
                        {
                            "type" => "has-component",
                            "target" => {
                                "reference" => "#3025861-q6930384"
                            }
                        }
                    ]
                }
            },
            {
                "resource" => {
                    "resourceType" => "Observation",
                    "id" => "M4637256",
                    "meta" => {
                        "versionId" => "17-4637255",
                        "lastUpdated" => "2015-10-16T07:17:08.000Z"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Observation&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: 2744010&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Auth (Verified)&lt;/p>&lt;p>&lt;b>Code&lt;/b>: Sodium Lvl&lt;/p>&lt;p>&lt;b>Result&lt;/b>: 234 mEq/dL&lt;/p>&lt;p>&lt;b>Date&lt;/b>: 2015-04-17T06:32:00.000Z&lt;/p>&lt;p>&lt;b>Risk Level Detail&lt;/b>: Low: 135 mEq/dL High: 150 mEq/dL&lt;/p>&lt;/div>"
                    },
                    "code" => {
                        "coding" => [
                            {
                                "system" => "http://loinc.org",
                                "code" => "2951-2",
                                "display" => "SODIUM:SCNC:PT:SER/PLAS:QN:"
                            }
                        ],
                        "text" => "Sodium Lvl"
                    },
                    "valueQuantity" => {
                        "value" => 234,
                        "units" => "mEq/dL",
                        "system" => "http://unitsofmeasure.org",
                        "code" => "meq/dL"
                    },
                    "interpretation" => {
                        "text" => "CRIT"
                    },
                    "appliesDateTime" => "2015-04-17T06:32:00.000Z",
                    "issued" => "2015-04-17T06:36:44.000Z",
                    "status" => "final",
                    "subject" => {
                        "reference" => "Patient/2744010"
                    },
                    "encounter" => {
                        "reference" => "Encounter/2951906"
                    },
                    "referenceRange" => {
                        "low" => {
                            "value" => 135,
                            "units" => "mEq/dL",
                            "system" => "http://unitsofmeasure.org",
                            "code" => "meq/dL"
                        },
                        "high" => {
                            "value" => 150,
                            "units" => "mEq/dL",
                            "system" => "http://unitsofmeasure.org",
                            "code" => "meq/dL"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "Observation",
                    "id" => "M4637264",
                    "meta" => {
                        "versionId" => "17-4637263",
                        "lastUpdated" => "2015-10-16T07:17:23.000Z"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Observation&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: 2744010&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Auth (Verified)&lt;/p>&lt;p>&lt;b>Code&lt;/b>: Chloride&lt;/p>&lt;p>&lt;b>Result&lt;/b>: 233 mmol/L&lt;/p>&lt;p>&lt;b>Date&lt;/b>: 2015-04-17T06:24:00.000Z&lt;/p>&lt;p>&lt;b>Risk Level Detail&lt;/b>: Low: 98 mmol/L High: 107 mmol/L&lt;/p>&lt;/div>"
                    },
                    "code" => {
                        "coding" => [
                            {
                                "system" => "http://loinc.org",
                                "code" => "2075-0",
                                "display" => "CHLORIDE:SCNC:PT:SER/PLAS:QN:"
                            }
                        ],
                        "text" => "Chloride"
                    },
                    "valueQuantity" => {
                        "value" => 233,
                        "units" => "mmol/L",
                        "system" => "http://unitsofmeasure.org",
                        "code" => "mmol/L"
                    },
                    "interpretation" => {
                        "text" => "CRIT"
                    },
                    "appliesDateTime" => "2015-04-17T06:24:00.000Z",
                    "issued" => "2015-04-17T06:42:24.000Z",
                    "status" => "final",
                    "subject" => {
                        "reference" => "Patient/2744010"
                    },
                    "encounter" => {
                        "reference" => "Encounter/2951906"
                    },
                    "referenceRange" => {
                        "low" => {
                            "value" => 98,
                            "units" => "mmol/L",
                            "system" => "http://unitsofmeasure.org",
                            "code" => "mmol/L"
                        },
                        "high" => {
                            "value" => 107,
                            "units" => "mmol/L",
                            "system" => "http://unitsofmeasure.org",
                            "code" => "mmol/L"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "Observation",
                    "id" => "M4637268",
                    "meta" => {
                        "versionId" => "17-4637267",
                        "lastUpdated" => "2015-10-16T07:17:23.000Z"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Observation&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: 2744010&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Auth (Verified)&lt;/p>&lt;p>&lt;b>Code&lt;/b>: BUN&lt;/p>&lt;p>&lt;b>Result&lt;/b>: 50 mg/dL&lt;/p>&lt;p>&lt;b>Date&lt;/b>: 2015-04-17T06:24:00.000Z&lt;/p>&lt;p>&lt;b>Risk Level Detail&lt;/b>: Low: 10 mg/dL High: 20 mg/dL&lt;/p>&lt;/div>"
                    },
                    "code" => {
                        "coding" => [
                            {
                                "system" => "http://loinc.org",
                                "code" => "3094-0",
                                "display" => "UREA NITROGEN:MCNC:PT:SER/PLAS:QN:"
                            }
                        ],
                        "text" => "BUN"
                    },
                    "valueQuantity" => {
                        "value" => 50,
                        "units" => "mg/dL",
                        "system" => "http://unitsofmeasure.org",
                        "code" => "mg/dL"
                    },
                    "interpretation" => {
                        "text" => "CRIT"
                    },
                    "appliesDateTime" => "2015-04-17T06:24:00.000Z",
                    "issued" => "2015-04-17T06:58:07.000Z",
                    "status" => "final",
                    "subject" => {
                        "reference" => "Patient/2744010"
                    },
                    "encounter" => {
                        "reference" => "Encounter/2951906"
                    },
                    "referenceRange" => {
                        "low" => {
                            "value" => 10,
                            "units" => "mg/dL",
                            "system" => "http://unitsofmeasure.org",
                            "code" => "mg/dL"
                        },
                        "high" => {
                            "value" => 20,
                            "units" => "mg/dL",
                            "system" => "http://unitsofmeasure.org",
                            "code" => "mg/dL"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "Observation",
                    "id" => "M4637260",
                    "meta" => {
                        "versionId" => "17-4637259",
                        "lastUpdated" => "2015-10-16T07:17:23.000Z"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Observation&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: 2744010&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Auth (Verified)&lt;/p>&lt;p>&lt;b>Code&lt;/b>: Potassium Lvl&lt;/p>&lt;p>&lt;b>Result&lt;/b>: 2.34 mEq/L&lt;/p>&lt;p>&lt;b>Date&lt;/b>: 2015-04-17T06:24:00.000Z&lt;/p>&lt;p>&lt;b>Risk Level Detail&lt;/b>: Low: 3.50 mEq/L High: 5.10 mEq/L&lt;/p>&lt;/div>"
                    },
                    "code" => {
                        "coding" => [
                            {
                                "system" => "http://loinc.org",
                                "code" => "2823-3",
                                "display" => "POTASSIUM:SCNC:PT:SER/PLAS:QN:"
                            }
                        ],
                        "text" => "Potassium Lvl"
                    },
                    "valueQuantity" => {
                        "value" => 2.34,
                        "units" => "mEq/L",
                        "system" => "http://unitsofmeasure.org",
                        "code" => "meq/L"
                    },
                    "interpretation" => {
                        "text" => "CRIT"
                    },
                    "appliesDateTime" => "2015-04-17T06:24:00.000Z",
                    "issued" => "2015-04-17T06:40:38.000Z",
                    "status" => "final",
                    "subject" => {
                        "reference" => "Patient/2744010"
                    },
                    "encounter" => {
                        "reference" => "Encounter/2951906"
                    },
                    "referenceRange" => {
                        "low" => {
                            "value" => 3.5,
                            "units" => "mEq/L",
                            "system" => "http://unitsofmeasure.org",
                            "code" => "meq/L"
                        },
                        "high" => {
                            "value" => 5.1,
                            "units" => "mEq/L",
                            "system" => "http://unitsofmeasure.org",
                            "code" => "meq/L"
                        }
                    }
                }
            },
            {
                "resource" => {
                    "resourceType" => "Observation",
                    "id" => "M4483270",
                    "meta" => {
                        "versionId" => "1-4483269",
                        "lastUpdated" => "2015-03-13T18:15:31.000Z"
                    },
                    "text" => {
                        "status" => "generated",
                        "div" => "&lt;div>&lt;p>&lt;b>Observation&lt;/b>&lt;/p>&lt;p>&lt;b>Patient&lt;/b>: 2744010&lt;/p>&lt;p>&lt;b>Status&lt;/b>: Auth (Verified)&lt;/p>&lt;p>&lt;b>Code&lt;/b>: CRP-hs&lt;/p>&lt;p>&lt;b>Result&lt;/b>: 3.1 mg/L&lt;/p>&lt;p>&lt;b>Risk Level&lt;/b>: Above high normal&lt;/p>&lt;p>&lt;b>Date&lt;/b>: 2015-03-13T18:10:00.000Z&lt;/p>&lt;p>&lt;b>Risk Level Detail&lt;/b>: Low: 1.0 mg/L High: 3.0 mg/L&lt;/p>&lt;/div>"
                    },
                    "code" => {
                        "coding" => [
                            {
                                "system" => "http://loinc.org",
                                "code" => "30522-7",
                                "display" => "C REACTIVE PROTEIN:MCNC:PT:SER/PLAS:QN:HIGH SENSITIVITY"
                            }
                        ],
                        "text" => "CRP-hs"
                    },
                    "valueQuantity" => {
                        "value" => 3.1,
                        "units" => "mg/L",
                        "system" => "http://unitsofmeasure.org",
                        "code" => "mg/L"
                    },
                    "interpretation" => {
                        "coding" => [
                            {
                                "system" => "http://hl7.org/fhir/v2/0078",
                                "code" => "H",
                                "display" => "Above high normal"
                            }
                        ],
                        "text" => "HI"
                    },
                    "appliesDateTime" => "2015-03-13T18:10:00.000Z",
                    "issued" => "2015-03-13T18:15:30.000Z",
                    "status" => "final",
                    "subject" => {
                        "reference" => "Patient/2744010"
                    },
                    "encounter" => {
                        "reference" => "Encounter/2951906"
                    },
                    "referenceRange" => {
                        "low" => {
                            "value" => 1.0,
                            "units" => "mg/L",
                            "system" => "http://unitsofmeasure.org",
                            "code" => "mg/L"
                        },
                        "high" => {
                            "value" => 3.0,
                            "units" => "mg/L",
                            "system" => "http://unitsofmeasure.org",
                            "code" => "mg/L"
                        }
                    }
                }
            }
        ]
    }

  end
end

include Cerner::Resources::Helpers